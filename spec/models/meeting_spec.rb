require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :starts_at }
  end
  
  context "Respecting Demeter's Law" do
    subject { FactoryGirl.build :meeting }
    
    it 'should provide access to the user name' do
      expect(subject.user_name).to eq('Test User')
    end
  end
end