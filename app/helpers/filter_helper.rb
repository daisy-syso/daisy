module FilterHelper

  def generate_price_filters prices
    filters = prices.each_cons(2).map do |from, to|
      Hash.new.tap do |ret|
        ret[:title] = "#{from} ~ #{to} 元"
        ret[:params] = { "price[from]" => from, "price[to]" => to }
      end
    end
    last = Hash.new.tap do |ret|
      ret[:title] = "#{prices.last} 元 以上"
      ret[:params] = { "price[from]" => prices.last, "price[to]" => nil }
    end
    filters + [ last ]
  end

end
