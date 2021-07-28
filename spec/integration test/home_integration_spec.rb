require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before(:each) do 
    User.create(name: 'User1') 
  end

  describe "Login is required" do
    it "Login is required" do
      visit root_path
      expect(page).to have_content('Login') 
    end
  end

  it 'No access for unsigned out' do
    visit root_path.to_s
    expect(page).to_not have_content('Logout')
  end

  it 'Login using name already registered' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    expect(page).to have_content('Log out')
  end

  it 'User can sign up' do
    visit signup_path
    fill_in 'Type your name', with: 'User2'
    click_button 'Create User'
    expect(page).to have_content('User Profile')
  end

  it 'Redirects to Home after successufully logged in.' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    expect(page).to have_content('All my portfolio')
  end

  it 'Users can log out once they log in successfully' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    click_link("Log out", :match => :first)
    expect(page).to have_content('Logged out!')
  end
end
