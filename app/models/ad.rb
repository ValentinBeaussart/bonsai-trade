class Ad < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, :place, :description, :price, presence: true
end
