require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it "does not require email" do
    admin = AdminUser.new(password: 'password')
    expect(admin.email_required?).to be_falsey
    expect(admin).to be_valid
  end
end
