class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root, only: [:new, :create]

  def new
    @purchase = Purchase.new
    gon.public_key = Rails.application.credentials.payjp[:public_key]
  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.valid?
      charge_item
      @purchase.save
      redirect_to root_path
    else
      gon.public_key = Rails.application.credentials.payjp[:public_key]
      puts "Purchase validation errors: #{@purchase.errors.full_messages}"
      render :new
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:postal_code, :prefecture_id, :city, :street, :building, :phone_number, :token).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def charge_item
    ENV['SSL_CERT_FILE'] = '/usr/local/etc/ca-certificates/cert.pem'

    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
