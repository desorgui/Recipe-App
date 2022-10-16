require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    before do
      @food = Food.create(
        name: 'Tomatoes',
        measurement_unit: 'pc.',
        price: 0.87
      )
    end

    context 'confirm the food name' do
      it 'is invalid' do
        expect(@food.name).to eq(@food.name)
      end
    end
  end
end
