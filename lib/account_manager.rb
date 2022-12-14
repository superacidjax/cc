require_relative '../lib/account'
require_relative '../lib/parser'
require_relative '../lib/sorter/sorter'
require_relative '../lib/formatter/formatter'

class AccountManager
  class << self
    def process(line_item)
      action = line_item.first
      args = line_item.slice(1..line_item.index(line_item.last))
      send(action.downcase, args)
    end

    def add(args)
      add_account(Account.new(Parser.parse_add_arg(args)))
    end

    def charge(args)
      parsed_args = Parser.parse_charge_arg(args)
      account = find(parsed_args.fetch(:owner))
      account.charge(parsed_args.fetch(:amount)) if account.is_valid?
    end

    def credit(args)
      parsed_args = Parser.parse_credit_arg(args)
      account = find(parsed_args.fetch(:owner))
      account.credit(parsed_args.fetch(:amount)) if account.is_valid?
    end

    def find(name)
      accounts.find { |account| account if account.owner == name }
    end

    def accounts
      @@accounts ||= []
    end

    def summarize
      Formatter.new(sorted_accounts).print
    end

    def sorted_accounts(attr = 'owner')
      Sorter.new(accounts, attr).sort
    end

    private

    def add_account(account)
      accounts << account
    end
  end
end
