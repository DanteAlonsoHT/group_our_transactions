require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { 'simple name' }
  let(:user) { User.create(name: 'User1') }
  let(:fatal_user) { User.new }
  let(:short_user) { User.create(name: 'a') }
  let(:long_user) do
    User.create(name: "I can't imagine someone who has a too long name,
                                        it would be interesting to know someday")
  end

  describe 'Users can be created and validated' do
    it 'User can be created' do
      expect(user.valid?).to eq(true)
    end

    it 'User can not be created' do
      expect(fatal_user.valid?).to eq(false)
    end

    it 'Username too short' do
      expect(short_user.valid?).to eq(false)
    end

    it 'Username too long' do
      expect(long_user.valid?).to eq(false)
    end
  end
end
