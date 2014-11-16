require 'rails_helper'

feature "A non-admin user accessing the meetings calendar", :type => :feature do
  given(:today) { '2014-11-13'.to_date }

  background do
    allow(Date).to receive(:today).and_return(today)
    @derp1 = FactoryGirl.create(:user)
    @derp2 = FactoryGirl.create(:user)
    @test_meeting1 = FactoryGirl.create(:meeting, user: @derp1, starts_at: '2014-11-11 08:00')
    @test_meeting2 = FactoryGirl.create(:meeting, user: @derp2, starts_at: '2014-11-11 09:00')
    login_as(@derp1, :scope => :user)
    visit meetings_path
  end
  
  scenario "should create a meeting by clicking in an availiable date and hour calendar icon", js: true do
    within('.meeting-container.date-20141110070000') do
      find('.create-meeting').click
    end
    
    expect(page.find('.meeting-container.date-20141110070000 i.fa-user span').text).to eq(@derp1.name)
  end

  scenario "should delete a meeting by clicking in the trash icon", js: true do
    within('.meeting-container.date-20141111080000') do
      find('.delete-link').click
      confirm_dialog
    end
    
    expect(page.find('.meeting-container.date-20141111080000 .create-meeting')).to be_truthy
  end
  
  scenario "should not see the delete icon for other users meetings" do
    within('.meeting-container.date-20141111090000') do
      expect{ find('.delete-link') }.to raise_error(Capybara::ElementNotFound)
      expect(find('i.fa-user span').text).to eq(@derp2.name)
    end
  end
end