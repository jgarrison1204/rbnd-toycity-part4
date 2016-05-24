module Analyzable
  # Your code goes here!
  @@counter_brand = {}
  @@counter_name = {}

  def average_price(all_data)
    @total_price = 0
    all_data.each do |price|
      @total_price += price.price.to_f
    end
    @average = (@total_price/all_data.length).round(2)
  end

  def count_by_name(all_data)
    set_name_count = all_data.select {|product| @@counter_name[product.name] = 0}
    set_name_count.each {|product| @@counter_name[product.name] += 1}
    return @@counter_name
  end

  def count_by_brand(all_data)
    set_brand_count = all_data.select {|product| @@counter_brand[product.brand] = 0}
    set_brand_count.each {|product| @@counter_brand[product.brand] += 1}
    return @@counter_brand
  end

  def print_report(all_data)
    reporter = "Average price for all toys: #{average_price(all_data)}\n"
    reporter += "Count by brand:\n"
    count_by_brand(all_data).each do |brand, number|
      reporter += "   #{brand}: #{number}\n"
    end
    reporter += "Count by name:\n"
    count_by_name(all_data).each do |name, number|
      reporter += "   #{name}: #{number}\n"
    end
    reporter
  end
end
