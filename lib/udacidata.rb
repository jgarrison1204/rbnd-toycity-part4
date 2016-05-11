require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(options={})
    product_to_add = Product.new(options)
    #"a+" is from the IO open mode which tells the file to Read-write see  http://ruby-doc.org/core-2.0.0/IO.html#method-c-new-label-IO+Open+Mode
    CSV.open(@@data_path, "a+") do |csv|
      csv << [product_to_add.id, product_to_add.brand, product_to_add.name, product_to_add.price]
    end
    product_to_add
  end

  #sourced from https://discussions.udacity.com/t/expected-id-brand-product-price-to-be-an-instance-of-product-not-array/167823
  def self.all
    products = [] #to hold the instances we will create.
    CSV.read(@@data_path, headers:true).each do |product| #read the CSV and iterate over each row
      #create a new instance of Product and add it to the products array.
      products << self.new(id: product["id"], brand: product["brand"], name: product["product"], price: product["price"])
    end
    #return the array of products.
    products
  end
end
