require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:name) { 'Name123' }
  let(:user) { User.create(name: 'User1', id: 1) }
  let(:group) { Group.create(name: 'Group1', user_id: user.id, id: 1) }
  let(:fatal_group) { Group.new(name: 'Group2') }

  let(:group_by_ghost_user) { Group.create(name: 'Group1', user_id: 100_000) }

  let(:investment) { Investment.new(crypto: 'Bitcoin', amount: 0.0055, user_id: user.id) }
  let(:investment2) { Investment.new(crypto: 'Dogecoin', amount: 2030.5, user_id: user.id) }

  let(:too_short_name_group) { Group.create(name: 'a', user_id: user.id, id: 1) }
  let(:too_long_name_group) do
    Group.create(name: 'In another life, I would be your girl, we have keep all our
                                                  promises be us against the world', user_id: user.id, id: 1)
  end

  describe 'Validating name group' do
    it 'if the name group is too short, it should not be valid' do
      expect(too_short_name_group).to_not be_valid
    end

    it 'if the name group is too loog, it should not be valid as well' do
      expect(too_long_name_group).to_not be_valid
    end
  end

  describe 'User must exist to create a group' do
    it "Is not valid if user who doesn't exist is trying to create a group" do
      expect(group_by_ghost_user).to_not be_valid
    end
  end

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
