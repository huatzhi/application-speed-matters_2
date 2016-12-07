require 'rails_helper'

RSpec.feature "Paginations", type: :feature do
  describe 'GET /' do
    before do 
      88.times do
        create(:user)
      end
    end

    it "get correct number of page" do
      visit '/?page=2'
      expect(page).to have_content("Current Page: 2")
    end

    it 'mark the correct page as active' do
      visit '/?page=3'
      # expect(page).to have_xpath("//*[@class='pagination']//li[@class='active']//a[text()='3']")
      expect(page).to have_css('li.active a', text: '3')
    end

    it 'disable previous if the user on first page' do
      visit '/'
      # expect(page).to have_xpath("//*[@class='pager']//li[@class='previous disabled']")
      expect(page).to have_css('li.previous.disabled')
    end

    it 'disable next if the user on last page' do
      visit '/?page=9'
      expect(page).to have_css('li.next.disabled')
    end
  end


end
