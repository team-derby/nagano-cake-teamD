class Product < ApplicationRecord

	has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  attachment :image

  enum genre_id:{ ケーキ: 0, プリン: 1, 焼き菓子: 2, キャンディ: 3}
  enum sales_status:{ 販売中: 0, 売切れ: 1}

  validates :name, presence: true, length: {maximum: 50}
  validates :explanation, length: {maximum: 200}
end
