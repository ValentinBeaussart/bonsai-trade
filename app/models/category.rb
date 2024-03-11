# frozen_string_literal: true

class Category < ApplicationRecord # rubocop:disable Style/Documentation
  has_many :ads
end
