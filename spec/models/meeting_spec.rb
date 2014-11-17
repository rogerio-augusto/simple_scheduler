require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  context "Basic validations" do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :starts_at }
    
    it 'should not create more than one meeting at the same hour' do
      user = FactoryGirl.create(:user)
      meeting_a = FactoryGirl.create(:meeting, user: user, starts_at: '2014-11-11 09:20')
      
      meeting_b = FactoryGirl.build(:meeting, user: user, starts_at: '2014-11-11 09:00')
      meeting_c = FactoryGirl.build(:meeting, user: user, starts_at: '2014-11-11 09:59')
      meeting_d = FactoryGirl.build(:meeting, user: user, starts_at: '2014-11-11 10:00')

      expect(meeting_b.save).to be_falsey
      expect(meeting_b.errors.messages).to eq({starts_at: [I18n.t('activerecord.errors.models.meeting.only_one_meeting_day_and_hour')]})
      expect(meeting_c.save).to be_falsey
      expect(meeting_c.errors.messages).to eq({starts_at: [I18n.t('activerecord.errors.models.meeting.only_one_meeting_day_and_hour')]})
      expect(meeting_d.save).to be_truthy
    end
  end
  
  context "Respecting Demeter's Law" do
    subject { FactoryGirl.build :meeting }
    
    it 'should provide access to the user name' do
      user = subject.user
      expect(subject.user_name).to eq(user.name)
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