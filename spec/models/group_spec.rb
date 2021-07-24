require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:name) { 'Name123' }
  let(:user) { User.create(name: 'User1', id: 1) }
  let(:group) { Group.create(name: 'Group1', user_id: user.id, id: 1) }
  let(:fatal_group) { Group.new(name: 'Group2') }

  let(:investment) { Investment.new(crypto: 'Bitcoin', amount: 0.0055, user_id: user.id) }
  let(:investment2) { Investment.new(crypto: 'Dogecoin', amount: 2030.5, user_id: user.id) }

  describe 'Group can be created and validated' do
    it 'User can create a group' do
      new_group = user.groups.new(name: 'Group1', id: 3)
      new_group.save

      expect(new_group.valid?).to eq(true)
    end

    it 'Group validates presence of any field' do
      expect(fatal_group.save).to eq(false)
    end

    it 'Group can have many investments' do
      investment.group_id = group.id
      investment2.group_id = group.id

      investment.save
      investment2.save

      expect(Investment.all.where(group_id: group.id).count).to eq(2)
    end
  end
end
