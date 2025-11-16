require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end

  describe '商品購入' do
    context '購入できる場合' do
      it '全ての情報が正しく入力されていれば購入できる' do
        expect(@purchase).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @purchase.building = ''
        expect(@purchase).to be_valid
      end
    end

    context '購入できない場合' do
      it 'postal_codeが空だと購入できない' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end

      it 'postal_codeがハイフン無しだと購入できない' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Postal code is invalid')
      end

      it 'prefecture_idが空だと購入できない' do
        @purchase.prefecture_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと購入できない' do
        @purchase.city = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空だと購入できない' do
        @purchase.street = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Street can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @purchase.phone_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁未満だと購入できない' do
        @purchase.phone_number = '090123456'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @purchase.phone_number = '090123456789'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空だと購入できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
