require 'rails_helper'

RSpec.describe Investment, type: :model do
  let(:name) { 'Name123' }
  let(:user) { User.create(name: 'User1') }
  let(:group) { Group.create(name: 'Group1', user_id: user.id) }
  let(:investment) { Investment.create(crypto: 'Bitcoin', amount: 0.0055, user_id: user.id, group_id: group.id) }
  let(:fatal_investment_amount) { Investment.new(crypto: 'Dogecoin', user_id: user.id) }
  let(:fatal_investment_crypto) { Investment.new(amount: 0.0055, user_id: user.id) }
  let(:fatal_investment_user_id) { Investment.new(crypto: 'Dogecoin', amount: 0.0055, group_id: group.id) }

  describe 'Investment can be created and validated' do
    it 'Investment can be created' do
      expect(investment).to be_valid
    end

    it 'User can create a investment' do
      new_investment = user.investments.create(crypto: 'Bitcoin', amount: 0.0055, group_id: group.id)

      expect(new_investment).to be_valid
    end
  end

  describe 'Investment can not be created if field(s) required are not already filled' do
    it 'Crypto is missing' do
      expect(fatal_investment_crypto.valid?).to eq(false)
    end

    it 'Amount is missing' do
      expect(fatal_investment_amount.valid?).to eq(false)
    end

    it 'User id is missing' do
      expect(fatal_investment_user_id.valid?).to eq(false)
    end
  end
end
