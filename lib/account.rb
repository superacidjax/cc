require 'rspec'
require_relative '../lib/validator'

class Account

  attr_reader :owner, :card_number, :status, :card_limit
  attr_accessor :card_balance

  def initialize(args)
    @owner = args[:owner]
    @card_number = args[:card_number]
    @card_limit = args[:card_limit]
    @card_balance = 0
    @status = is_validated?(card_number)
  end

  def charge(amount)
    if (card_balance + amount) < card_limit
      self.card_balance += amount
    end
  end

  def credit(amount)
    self.card_balance -= amount
  end

  def is_valid?
    @status == 'valid'
  end

  def is_validated?(card_number)
    Validator.valid?(card_number) ? 'valid' : 'invalid'
  end
end
