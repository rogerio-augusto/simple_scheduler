require 'rails_helper'

RSpec.describe MeetingsController, :type => :controller do
  let!(:today) { '2014-11-13'.to_date }

  before(:all) do
    @user = FactoryGirl.create(:user)
    @meeting_a = FactoryGirl.create(:meeting, starts_at: '2014-11-13 09:00', user: @user)
    @meeting_b = FactoryGirl.create(:meeting, starts_at: '2014-11-14 15:00', user: @user)
    @meeting_c = FactoryGirl.create(:meeting, starts_at: '2014-11-17 08:00', user: @user)
    @old_meeting_a = FactoryGirl.create(:meeting, starts_at: '1980-08-11 09:00', user: @user)
    @old_meeting_b = FactoryGirl.create(:meeting, starts_at: '1980-08-12 15:00', user: @user)
    @old_meeting_c = FactoryGirl.create(:meeting, starts_at: '1980-08-08 08:00', user: @user)
  end
    
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user
    allow(Date).to receive(:today).and_return(today)
  end

  after(:each) do
    allow(Date).to receive(:today).and_call_original
  end  
  
  describe 'GET #index' do  
    it 'should assign a new meeting variable' do
      get :index
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end

    context 'a fresh access without the start_date parameter' do
      it 'should assign the starting date as today' do
        get :index
        expect(assigns(:start_date)).to eq(today)
      end
      
      it 'should assign the meetings for the current week' do
        get :index
        expect(assigns(:meetings)).to include(@meeting_b, @meeting_a)
      end

      it "should not include other week's meetings in the assigned meetings" do
        get :index
        expect(assigns(:meetings)).not_to include(@meeting_c, @old_meeting_a, @old_meeting_b, @old_meeting_c)
      end
    end
    
    context 'an access providing the start_date parameter' do
      it 'should use the start_date parameter to assign a date object' do
        get :index, start_date: '1980-08-11'
        expect(assigns(:start_date)).to eq('11/08/1980'.to_date)
      end
      
      it 'should rescue to the current date, if the provided start_date is an invalid date' do
        get :index, start_date: '9999-50-11'
        expect(assigns(:start_date)).to eq(today)
      end
      
      it "should assign the meetings for the provided date's week" do
        get :index, start_date: '1980-08-11'
        expect(assigns(:meetings)).to include(@old_meeting_a, @old_meeting_b)
      end

      it "should not include other week's meetings in the assigned meetings" do
        get :index, start_date: '1980-08-11'
        expect(assigns(:meetings)).not_to include(@old_meeting_c, @meeting_a, @meeting_b, @meeting_c)
      end
    end
  end
end