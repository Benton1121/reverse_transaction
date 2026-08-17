require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'should belongs to user' do
    is_expected.to belong_to(:user)
  end

  describe '.balance' do
    let(:invoice) { create :invoice }

    it 'returns 0 if no transactions exists' do
      expect(invoice.balance).to eq(0)
    end

    context 'when got transactions' do
      let!(:tr_a) { create :transaction, price_cents: 10_00, invoice: }
      let!(:tr_b) { create :transaction, price_cents: 20_00, invoice: }

      it 'returns sum of transaction balances' do
        expect(invoice.balance).to eq(30_00)
      end
    end

    context 'when got reversed transactions' do
      let!(:tr_a) { create :transaction, price_cents: 20_00, invoice: }
      let!(:tr_b) { create :transaction, price_cents: -10_00, invoice: }

      it 'returns sum of transaction balances' do
        expect(invoice.balance).to eq(10_00)
      end
    end
  end
end
