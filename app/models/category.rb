# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :doctors, class_name: 'User'

  validates :name, presence: true, uniqueness: true
end
