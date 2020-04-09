class Delivery < ApplicationRecord
	belongs_to :user

  validates :post_number, presence: true, length: { maximum: 7 }
  validates :post_address, presence: true
  validates :post_name, presence: true

  def view_addresses
    self.post_number + self.post_address + self.post_name
  end
end
