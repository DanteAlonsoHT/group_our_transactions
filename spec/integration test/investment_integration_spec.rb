require 'rails_helper'

RSpec.describe 'Group', type: :system do
    before(:each) do 
        User.create(name: 'User1')
        Group.create(name: 'Group1', user_id: User.where(name: 'User1').first.id)
        Investment.create(crypto: "Bitcoin", amount: 0.005, 
            user_id: User.where(name: 'User1').first.id, group_id: Group.where(name: 'Group1').first.id,)
    end

    it "Login is required" do
        visit investments_path
        expect(page).to have_content('Login') 
    end

    it 'Logged user can go to see all groups' do
        visit root_path
        fill_in 'Type your name', with: 'User1'
        click_button 'Login'
        visit investments_path
        expect(page).to have_content('Bitcoin')
    end

    it 'User can show an investment' do
        visit root_path
        fill_in 'Type your name', with: 'User1'
        click_button 'Login'
        visit investments_path
        click_link("Show", :match => :first)
        expect(page).to have_content('Details')
    end

    it 'User can edit an investment.' do
        visit root_path
        fill_in 'Type your name', with: 'User1'
        click_button 'Login'
        visit investments_path
        click_link("Edit", :match => :first)
        expect(page).to have_content('Editing Investments')
    end

    it 'Users can create an investment' do
        visit root_path
        fill_in 'Type your name', with: 'User1'
        click_button 'Login'
        visit investments_path
        click_link("New Investment")
        fill_in 'Amount:', with: 0.035
        click_button 'Create Investment'
        expect(page).to have_content('Investment was successfully created.')
    end
end
