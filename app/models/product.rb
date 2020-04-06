class Product < ApplicationRecord
  belongs_to :genre
	has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  attachment :image

  enum sales_status:{ 販売中: 0, 売切れ: 1}

  validates :name, presence: true, length: {maximum: 50}
  validates :explanation, length: {maximum: 200}
end
