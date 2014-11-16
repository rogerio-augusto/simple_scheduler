require 'rails_helper'

feature "An admin user accessing the meetings calendar", :type => :feature do
  given(:today) { '2014-11-13'.to_date }

  background do
    allow(Date).to receive(:today).and_return(today)
    @admin = FactoryGirl.create(:user, admin: true)
    @derp = FactoryGirl.create(:user)
    @derp_meeting = FactoryGirl.create(:meeting, user: @derp, starts_at: '2014-11-11 09:00')
    login_as(@admin, :scope => :user)
    visit meetings_path
  end
  
  scenario "should delete other users meetings by clicking in the trash icon", js: true do
    within('.meeting-container.date-20141111090000') do
      find('.delete-link').click
      confirm_dialog
    end
    
    expect(page.find('.meeting-container.date-20141111090000 .create-meeting')).to be_truthy
  end
end