module Analyzable
  # Your code goes here!
  @@total_price = 0
  @@counter = []
  @@counter_brand = {}
  @@counter_name = {}

  def average_price(object)
    object.each do |price|
      @@total_price += price.price.to_f
      @@counter << price
    end
    average = (@@total_price/@@counter.length).round(2)
  end

  def print_report(all_data)
    all_data.map {|product| product}.to_s
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
