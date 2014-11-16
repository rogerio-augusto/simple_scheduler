require 'rails_helper'

RSpec.describe Room, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :name }
  end
end
