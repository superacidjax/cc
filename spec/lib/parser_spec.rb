require 'spec_helper'
require_relative '../../lib/parser'

RSpec.describe Parser do
  it 'parses argument for add' do
    args = ['Tom', '42', '$200']

    expect(Parser.parse_add_arg(args)[:owner]).to eql('Tom')
    expect(Parser.parse_add_arg(args)[:card_number]).to eql(42)
    expect(Parser.parse_add_arg(args)[:card_limit]).to eql(200)
  end

  it 'parses argument for charge' do
    args = ['Penny', '$300']

    expect(Parser.parse_charge_arg(args)[:owner]).to eql('Penny')
    expect(Parser.parse_charge_arg(args)[:amount]).to eql(300)
  end

  it 'parses argument for credit' do
    args = ['Jessica', '$500']

    expect(Parser.parse_credit_arg(args)[:owner]).to eql('Jessica')
    expect(Parser.parse_credit_arg(args)[:amount]).to eql(500)
  end
end
