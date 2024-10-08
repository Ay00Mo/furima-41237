require 'rails_helper'

RSpec.describe OrderMailingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user) # rubocop:disable Style/HashSyntax
    @order_mailing_address = FactoryBot.build(:order_mailing_address, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_mailing_address).to be_valid
      end
      it 'addressは空でも保存できる' do
        @order_mailing_address.address = ''
        expect(@order_mailing_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @order_mailing_address.postal_code = ''
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_mailing_address.postal_code = '1234567'
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できない' do
        @order_mailing_address.prefecture_id = 1
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できない' do
        @order_mailing_address.city = ''
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("City can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @order_mailing_address.phone_number = ''
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが数字以外を含むと保存できない' do
        @order_mailing_address.phone_number = '090-1234-5678'
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("Phone number is invalid. Only allows numbers") # rubocop:disable Style/StringLiterals
      end
      it 'userが紐づいていないと保存できない' do
        @order_mailing_address.user_id = nil
        @order_mailing_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと保存できない' do
        @order_mailing_address.item_id = nil
        @order_miling_address.valid?
        expect(@order_mailing_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
