require 'rails_helper'

feature "Any user accessing the meetings calendar", :type => :feature do
  given(:today) { '2014-11-13'.to_date }

  background do
    allow(Date).to receive(:today).and_return(today)
    @admin = FactoryGirl.create(:user, admin: true)
    @test_meeting = FactoryGirl.create(:meeting, user: @admin, starts_at: '2014-11-11 08:00')
    login_as(@admin, :scope => :user)
    visit meetings_path
  end

  scenario "should render the current week days in the main table" do
    expect(page.find('table.calendar th', text: /\ASeg 10\/11\/2014\z/)).to be_truthy
    expect(page.find('table.calendar th', text: /\ASex 14\/11\/2014\z/)).to be_truthy
  end

  scenario "should render from 6:00 to 23:00 hours in the main table" do
    expect(page.find('table.calendar th', text: /06:00/)).to be_truthy
    expect(page.find('table.calendar th', text: /23:00/)).to be_truthy
  end
  
  scenario "should create a meeting by clicking in an availiable date and hour calendar icon", js: true do
    within('.meeting-container.date-20141110070000') do
      find('.create-meeting').click
    end
    
    expect(page.find('.meeting-container.date-20141110070000 i.fa-user span').text).to eq(@admin.name)
  end

  scenario "should delete a meeting by clicking in the trash icon", js: true do
    within('.meeting-container.date-20141111080000') do
      find('.delete-link').click
      confirm_dialog
    end
    
    expect(page.find('.meeting-container.date-20141111080000 .create-meeting')).to be_truthy
  end
end