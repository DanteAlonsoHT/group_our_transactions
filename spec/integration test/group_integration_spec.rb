require 'rails_helper'

RSpec.describe 'Group', type: :system do
  before(:each) do
    User.create(name: 'User1')
    Group.create(name: 'Group1', user_id: User.where(name: 'User1').first.id)
  end

  it 'Login is required' do
    visit groups_path
    expect(page).to have_content('Login')
  end

  it 'Logged user can go to see all groups' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    visit groups_path
    expect(page).to have_content('Groups')
  end

  it 'User can show a group' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    visit groups_path
    click_link('Show', match: :first)
    expect(page).to have_content('Group investments:')
  end

  it 'User can edit a group.' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    visit groups_path
    click_link('Edit', match: :first)
    expect(page).to have_content('Editing Group')
  end

  it 'Users can create a group' do
    visit root_path
    fill_in 'Type your name', with: 'User1'
    click_button 'Login'
    visit groups_path
    click_link('New Group')
    fill_in 'Type the name', with: 'Group2'
    click_button 'Create Group'
    expect(page).to have_content('Group was successfully created.')
  end
end
