class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship

  validates :item_name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :category_id, :condition_id, :shipping_fee_id,
            :prefecture_id, :days_to_ship_id, numericality: { other_than: 1, message: "can't be blank" }

  validate :image_presence

  def sold?
    Order.exists?(item_id: self.id) # rubocop:disable Style/RedundantSelf
  end

  private

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end
end
