require 'pry'
require 'spec_helper'
require_relative '../../lib/account'

RSpec.describe Account do

  before(:each) do
    @account = Account.new(owner: 'Brian', card_number: 123, card_limit: 500)
  end

  describe 'initializ the account' do

    it 'initializes the account owner name' do
      expect(@account.owner).to eql('Brian')
    end

    it 'initializes card number' do
      expect(@account.card_number).to eql(123)
    end

    it 'initializes credit limit' do
      expect(@account.card_limit).to eql(500)
    end

    it 'creates a zero starting balance' do
      expect(@account.card_balance).to eql(0)
    end

    it 'ensures an invalid status' do
      expect(@account.status).to eq('invalid')
    end
  end

  describe 'charge' do

    it 'increases balance to the specified amount' do
      @account.charge(50)
      expect(@account.card_balance).to eql(50)
    end

    it 'does not increase balance if the specified amount goes over limit' do
      @account.charge(2500)
      expect(@account.card_balance).to eql(0)
    end
  end

  describe 'credit' do

    it 'decreases balance to the specified amount' do
      @account.credit(500)
      expect(@account.card_balance).to eql(-500)
    end
  end

  describe 'is_valid?' do

    it 'it does not validate the account' do
      expect(@account.is_valid?).to be false
    end

    it 'validates an account' do
      valid_account = Account.new(
        owner: 'Brian', card_number: 4111111111111111, card_limit: 500)
      expect(valid_account.is_valid?).to be true
    end
  end
end
