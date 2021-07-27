require 'rails_helper'

RSpec.describe Investment, type: :model do
  let(:name) { 'Name123' }
  let(:user) { User.create(name: 'User1') }
  let(:group) { Group.create(name: 'Group1', user_id: user.id) }
  let(:investment) { Investment.create(crypto: 'Bitcoin', amount: 0.0055, user_id: user.id, group_id: group.id) }

  let(:short_investment) do
    Investment.create(crypto: 'Bitcoin', amount: 0.0000249925, user_id: user.id, group_id: group.id)
  end
  let(:long_investment) do
    Investment.create(crypto: 'Bitcoin', amount: 10_000_000_000, user_id: user.id, group_id: group.id)
  end
  let(:negative_investment) do
    Investment.create(crypto: 'Bitcoin', amount: -0.000001, user_id: user.id, group_id: group.id)
  end

  let(:fatal_investment_amount) { Investment.new(crypto: 'Dogecoin', user_id: user.id) }
  let(:fatal_investment_crypto) { Investment.new(amount: 0.0055, user_id: user.id) }
  let(:fatal_investment_user_id) { Investment.new(crypto: 'Dogecoin', amount: 0.0055, group_id: group.id) }

  let(:investment_to_ghost_group) do
    Investment.new(crypto: 'Dogecoin', amount: 55, user_id: user.id, group_id: 100_000)
  end
  let(:investment_to_ghost_user) do
    Investment.new(crypto: 'Dogecoin', amount: 55, user_id: 100_000, group_id: group.id)
  end

  describe 'Validating when unexisted user or group is presented' do
    it 'If group is not exist, it should not be valid' do
      expect(investment_to_ghost_group).to_not be_valid
    end

    it 'If user is not exist, it should not be valid' do
      expect(investment_to_ghost_user).to_not be_valid
    end
  end

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

  describe 'Amount in investment can be validated properly' do
    it 'When there is a short investment is valid, and it is normal in cryptocurrencies investments' do
      expect(short_investment).to be_valid
    end

    it 'When there is a too long investment is not valid, and it often is impossible' do
      expect(long_investment).to_not be_valid
    end

    it 'When there is a negative investment, it is impossible' do
      expect(negative_investment).to_not be_valid
    end
  end
end
