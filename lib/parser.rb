class Parser

  def self.parse_add_arg(args)
    { owner: args[0], card_number: args[1].to_i, card_limit: args[2].gsub(/\D/, '').to_i }
  end

  def self.parse_charge_arg(args)
    { owner: args[0], amount: args[1].gsub(/\D/, '').to_i }
  end

  def self.parse_credit_arg(args)
    { owner: args[0], amount: args[1].gsub(/\D/, '').to_i }
  end
end
