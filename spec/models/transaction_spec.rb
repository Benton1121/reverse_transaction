require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:amount_cents) { 10_00 }
  let(:transaction) { build :transaction, amount_cents: }

  describe '.spent?' do
    context 'when transaction adds funds to user balance' do
      it 'should not be spent' do
        expect(transaction.spent?).to be_falsey
      end
    end

    context 'when transaction substract funds from user balance' do
      let(:amount_cents) { -10_00 }

      it 'should be spent' do
        expect(transaction.spent?).to be_truthy
      end
    end
  end

  describe '.reverse?' do
    context 'when transaction adds funds to user balance' do
      it 'should be reverse' do
        expect(transaction.reverse?).to be_truthy
      end
    end

    context 'when transaction substract funds from user balance' do
      let(:amount_cents) { -10_00 }

      it 'should be reverse' do
        expect(transaction.reverse?).to be_falsey
      end
    end
  end
end
