require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'should belong to user' do
    is_expected.to belong_to(:user)
  end

  describe 'status' do
    let(:order) { build :order }

    it 'pending by default' do
      expect(order.status).to eq('pending')
    end

    it 'can be pending' do
      expect(order).to be_valid
    end

    context 'when status paid' do
      it 'is valid' do
        order.status = 'paid'

        expect(order).to be_valid
      end
    end

    context 'when status cancelled' do
      it 'is valid' do
        order.status = 'cancelled'

        expect(order).to be_valid
      end
    end

    context 'when status is wrong' do
      it 'is not valid' do
        expect do
          order.status = 'wrong'
        end.to raise_error(ArgumentError, "'wrong' is not a valid status")
      end
    end
  end
end
