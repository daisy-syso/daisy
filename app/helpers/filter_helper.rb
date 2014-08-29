module FilterHelper

  def generate_price_filters prices
    filters = prices.each_cons(2).map do |from, to|
      Hash.new.tap do |ret|
        ret[:title] = generate_price_title from, to
        ret[:params] = { "price[from]" => from, "price[to]" => to }
      end
    end
    last = Hash.new.tap do |ret|
      ret[:title] = generate_price_title prices.last
      ret[:params] = { "price[from]" => prices.last, "price[to]" => nil }
    end
    filters + [ last ]
  end

  def generate_price_title from, to = nil
    to ? "#{from} ~ #{to} 元" : "#{from} 元 以上"
  end

end
