class Genre < ApplicationRecord
	has_many :products, dependent: :destroy

  enum active_status:{ 有効: 0, 無効: 1}
  validates :name, presence: true, length: {maximum: 10}
  validates :active_status, presence: true
end
