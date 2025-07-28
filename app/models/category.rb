# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :doctors, class_name: 'User'

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end
end
