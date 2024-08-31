class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship

  validates :item_name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :user, presence: true

  validates :category_id, :condition_id, :shipping_fee_id,
            :prefecture_id, :days_to_ship_id, numericality: { other_than: 1, message: "can't be blank" }
end
