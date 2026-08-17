require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build :order }

  it 'should belong to invoice' do
    is_expected.to belong_to(:invoice)
  end

  it 'should associate to user' do
    is_expected.to have_one(:user).through(:invoice)
  end

  describe 'price' do
    it 'should have price' do
      expect(order.price_cents).not_to be_nil
    end

    context 'if price is nil' do
      let(:order) { build :order, price_cents: nil }

      it 'order should be invalid' do
        expect(order).not_to be_valid
      end
    end

    context 'if price is negative' do
      let(:order) { build :order, price_cents: -10_00 }

      it 'order should be invalid' do
        expect(order).not_to be_valid
      end
    end
  end

  describe 'status' do
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

  context 'change status to paid' do
    let(:initial_balance) { 20_00 }
    let(:user) { create :user }
    let(:invoice) { create :invoice, user: }
    let!(:initial_transaction) { create :transaction, price_cents: initial_balance, invoice: }

    context 'invoice got enough balance' do
      let(:order) { create :order, price_cents: 10_00, invoice: }

      context 'order paid' do
        before do 
          order.paid! 
        end

        subject(:transaction) { invoice.transactions.last }

        it 'creates spent transaction' do
          expect(transaction.spent?).to be_truthy
        end

        it 'amount of transaction equal order price' do
          expect(transaction.price_cents.abs).to eq(order.price_cents)
        end

        it 'reduces invoice balance' do
          expect(invoice.balance).to eq(initial_balance - order.price_cents)
        end
      end
    end
  end

  context 'change status to cancelled' do
    let(:initial_balance) { 20_00 }
    let(:user) { create :user }
    let(:invoice) { create :invoice, user: }
    let!(:initial_transaction) { create :transaction, price_cents: initial_balance, invoice: }

    context 'invoice got enough balance' do
      let(:order) { create :order, status: 'paid', price_cents: 10_00, invoice: }

      context 'order cancelled' do
        before do 
          order.cancelled! 
        end

        subject(:transaction) { invoice.transactions.last }

        it 'creates reverse transaction' do
          expect(transaction.reverse?).to be_truthy
        end

        it 'amount of transaction equal order price' do
          expect(transaction.price_cents.abs).to eq(order.price_cents)
        end

        it 'revert invoice balance to initial state' do
          expect(invoice.balance).to eq(initial_balance)
        end
      end
    end
  end
end
