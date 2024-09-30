class OrderMailingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Only allows numbers' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id) # rubocop:disable Style/HashSyntax
    MailingAddress.create(postal_code: postal_code, city: city, address: address, phone_number: phone_number, order_id: order.id) # rubocop:disable Style/HashSyntax
  end
end
