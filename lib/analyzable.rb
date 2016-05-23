module Analyzable
  # Your code goes here!
  @@total_price = 0
  @@counter_brand = {"whatever":0}
  @@counter_name = {}

  def average_price(object)
    object.each do |price|
      @@total_price += price.price.to_f
    end
    average = (@@total_price/object.length).round(2)
  end

  def print_report(all_data)
    reporter = "Average price for all toys: #{average_price(all_data)}\n"
    reporter += "Count by brand:"
    count_by_brand(all_data).each do |brand, number|
      reporter += "   #{brand} - #{number}\n"
    end
    reporter += "Count by name:"
    count_by_name(all_data).each do |name, number|
      reporter += "   #{name}: #{number}"
    end
    reporter
  end

  def count_by_brand(object)
    object.each_with_index {|product, index| @@counter_brand = {product.brand => index + 1}}
    return @@counter_brand
  end

  def count_by_name(object)
    object.each_with_index  {|product, index| @@counter_name = {product.name => index + 1}}
    return @@counter_name
  end
end
