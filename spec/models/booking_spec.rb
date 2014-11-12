require 'rails_helper'

RSpec.describe Booking, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :room_id }
    it { is_expected.to validate_presence_of :date_and_time }
  end
end
