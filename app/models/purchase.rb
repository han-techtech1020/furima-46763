class Purchase
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :user_id, :item_id, :token

  # バリデーション
  validates :postal_code, :prefecture_id, :city, :street, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  def save
    return false unless valid?

    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street: street,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end