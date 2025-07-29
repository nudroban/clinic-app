# frozen_string_literal: true

class User < ApplicationRecord
  VALID_PHONE = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/
  enum role: { patient: 0, doctor: 1 }
  after_initialize :set_default_role, if: :new_record?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:phone]
  has_one_attached :avatar
  belongs_to :category, optional: true

  validates :phone, uniqueness: true,
                    format: { with: VALID_PHONE },
                    presence: true,
                    length: { maximum: 10, minimum: 10 }

  scope :doctors, -> { where(role: :doctor) }
  scope :patients, -> { where(role: :patient) }

  def set_default_role
    self.role ||= :user
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
