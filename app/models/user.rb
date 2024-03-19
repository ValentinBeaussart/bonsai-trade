# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  validates :username, presence: true, uniqueness: true, length: { minimum: 1, maximum: 50, allow_blank: true }
  validates :email, presence: true, uniqueness: true, length: { minimum: 6, maximum: 60, allow_blank: true }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_secure_password
  has_many :ads
end
