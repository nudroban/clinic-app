# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      phone: '1234567890',
      password: 'password'
    }
  end

  describe 'phone validation' do
    it 'is invalid without a phone number' do
      user = User.new(valid_attributes.except(:phone))
      expect(user).to be_invalid
      expect(user.errors[:phone]).to be_present
    end

    it 'is invalid with a duplicate phone number' do
      User.create!(valid_attributes)
      duplicate_user = User.new(valid_attributes)
      expect(duplicate_user).to be_invalid
      expect(duplicate_user.errors[:phone]).to be_present
    end

    it 'is invalid with an improperly formatted phone number' do
      user = User.new(valid_attributes.merge(phone: '12345'))
      expect(user).to be_invalid
      expect(user.errors[:phone]).to be_present
    end

    it 'is valid with a proper phone number' do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end
  end

  describe 'default role' do
    it 'defaults to patient' do
      user = User.new(valid_attributes.except(:role))
      expect(user.role).to eq('patient')
    end
  end

  describe 'scopes' do
    it 'returns only doctors for .doctors' do
      patient = User.create!(valid_attributes)
      doctor = User.create!(valid_attributes.merge(phone: '0987654321', role: :doctor))
      expect(User.doctors).to include(doctor)
      expect(User.doctors).not_to include(patient)
    end

    it 'returns only patients for .patients' do
      patient = User.create!(valid_attributes)
      doctor = User.create!(valid_attributes.merge(phone: '0987654321', role: :doctor))
      expect(User.patients).to include(patient)
      expect(User.patients).not_to include(doctor)
    end
  end
end
