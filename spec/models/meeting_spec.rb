require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :starts_at }
  end
  
  context "Respecting Demeter's Law" do
    subject { FactoryGirl.build :meeting }
    
    it 'should provide access to the user name' do
      expect(subject.user_name).to eq('Test User')
    end
  end
  
  context "User permissions" do
    before(:each) do
      @admin = FactoryGirl.build(:user, admin: true)
      @derp = FactoryGirl.build(:user)
    end
    
    context "Without a logged in user" do
      it 'should not destroy any meeting' do
        SessionData.set_current_user(nil)
        meeting = FactoryGirl.build(:meeting, user: @admin)
        
        expect(meeting.destroy).to be_falsey
        expect(meeting.errors.messages).to eq({base: [I18n.t('warnings.user_audit_required')]})
      end
    end

    context "Logged in with a non admin account" do
      it "should be permitted to destroy his own meetings" do
        SessionData.set_current_user(@derp)
        meeting = FactoryGirl.build(:meeting, user: @derp)
        expect(meeting.destroy).to be_truthy
      end
      
      it "should not allow to destroy other people meetings" do
        SessionData.set_current_user(@derp)
        meeting = FactoryGirl.build(:meeting, user: @admin)
        expect(meeting.destroy).to be_falsey
        expect(meeting.errors.messages).to eq({base: [I18n.t('activerecord.errors.models.meeting.you_shall_not_pass')]})
      end
    end
    
    context "Logged in with an admin account" do
      it "should be permitted to destroy any meeting" do
        SessionData.set_current_user(@admin)
        meeting = FactoryGirl.build(:meeting, user: @derp)
        expect(meeting.destroy).to be_truthy
      end
    end
  end
end