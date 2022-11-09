require 'spec_helper'
require_relative '../../lib/account_manager'
require_relative '../../lib/formatter/formatter'

RSpec.describe AccountManager do

  after(:each) do
    AccountManager.accounts.clear
  end

  describe 'process' do

    it 'processes a line item' do
      line_item = ['Add', 'Brian', '4242424242424242', '$500']
      expect(AccountManager).to receive(:send).with(
        'add', ['Brian', '4242424242424242', '$500'])
      AccountManager.process(line_item)
    end
  end

  describe 'add' do

    it 'creates a new account and adds to the collection' do
      args = ['Brian', '4242424242424242', '$500']
      AccountManager.add(args)

      expect(AccountManager.accounts.size).to eql(1)
      expect(AccountManager.accounts.first.owner).to eql('Brian')
    end
  end

  describe 'charge' do

    it 'invokes account.charge if account is valid' do
      args = ['Brian', '4111111111111111', '$501']

      AccountManager.add(args)
      account = AccountManager.accounts.first

      expect(account).to receive(:charge).with(500)

      AccountManager.charge(['Brian', '$500'])
    end

    it 'does not invoke account.charge if account is not valid' do
      args = ['Brian', '4', '$500']
      AccountManager.add(args)

      account = AccountManager.accounts.first
      expect(account).to_not receive(:charge).with(500)

      AccountManager.charge(['Brian', '$500'])
    end
  end

  describe 'credit' do
    it 'invokes account.credit if account is valid' do
      args = ['Brian', '4242424242424242', '$500']
      AccountManager.add(args)
      account = AccountManager.accounts.first

      expect(account).to receive(:credit).with(500)

      AccountManager.credit(['Brian', '$500'])
    end

    it 'does not invoke account.charge if account is not valid' do
      args = ['Brian', '4', '$5000']
      AccountManager.add(args)

      account = AccountManager.accounts.first
      expect(account).to_not receive(:credit).with(500)

      AccountManager.credit(['Brian', '$500'])
    end
  end

  describe 'find' do
    it 'searches for account based on owner name and returns the first match' do
      args = ['Brian', '4', '$500']
      AccountManager.add(args)

      expect(AccountManager.find('Brian').owner).to eql('Brian')
    end

    it 'returns nil if account is not found' do
      expect(AccountManager.find('Jessica')).to eql(nil)
    end
  end

  describe 'accounts' do
    it 'returns the list of accounts' do
      args = ['Brian', '4242424242424242', '$500']
      AccountManager.add(args)

      expect(AccountManager.accounts.size).to eql(1)
      expect(AccountManager.accounts.first.owner).to eql('Brian')
    end
  end

  describe 'display_summary' do
    it 'displays in specified format' do
      args = ['Brian', '4242424242424242', '$500']
      AccountManager.add(args)
      formatter = Formatter.new(AccountManager.sorted_accounts)
      allow(Formatter).to receive(:new).and_return(formatter)

      expect(Formatter.new(AccountManager.sorted_accounts)).to receive(:print)

      AccountManager.summarize
    end

    describe 'sorted_accounts' do
      it 'sorts the account based on owner name' do
        args = ['Brian', '4242424242424242', '$500']
        args1 = ['Jessica', '4242424242424241', '$1500']
        AccountManager.add(args)
        AccountManager.add(args1)

        expect(AccountManager.sorted_accounts.first.owner).to eql('Brian')
        expect(AccountManager.sorted_accounts.last.owner).to eql('Jessica')
      end
    end
  end
end
