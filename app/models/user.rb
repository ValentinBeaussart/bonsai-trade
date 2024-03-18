# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :ads
end
