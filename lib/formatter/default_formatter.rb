class DefaultFormatter
  def print(data_set)
    data_set.each { |data| data.is_valid? ? print_valid(data) : print_invalid(data) }
  end

  def print_valid(data)
    puts "#{data.owner}: $#{data.card_balance}"
  end

  def print_invalid(data)
    puts "#{data.owner}: error"
  end
end
