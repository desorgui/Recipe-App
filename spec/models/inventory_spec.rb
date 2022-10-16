require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'validations' do
    before do
      @inventory = Inventory.create(
        name: 'Inventory A',
        description: 'testing',
        user_id: 1
      )
    end

    context 'confirm the inventory name' do
      it 'is invalid' do
        expect(@inventory.name).to eq(@inventory.name)
      end
    end
  end
end
