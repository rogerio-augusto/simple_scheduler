require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :room_id }
    it { is_expected.to validate_presence_of :starts_at }
  end
end
