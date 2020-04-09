class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :cart_items, allow_destroy: true
  accepts_nested_attributes_for :orders, allow_destroy: true

  enum profile_status:{ 有効: 0, 退会済: 1}

  
end
