require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  create_finder_methods("brand","name")
  def self.create(options={})
    product_to_add = Product.new(options)
    #"a+" is from the IO open mode which tells the file to Read-write see  http://ruby-doc.org/core-2.0.0/IO.html#method-c-new-label-IO+Open+Mode
    CSV.open(@@data_path, "a+") do |csv|
      csv << [product_to_add.id, product_to_add.brand, product_to_add.name, product_to_add.price.to_f]
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

  #Sets n = 1
  def self.first(n = 1)
    #default returns product object
    if n == 1
      all.first
    #If not default then returns an array of products.
    #range literal "..." excludes the end value in the range.
    else
      all[0...n]
    end
  end

  def self.last(n=0)
    if n == 0
      all.last
    else
      all[0...n]
    end
  end

  def self.find(n)
    finder = all.select {|product| return product if product.id == n}
    if finder.empty?
      raise NoProductReturnedError, "Sorry! This product does not exist. Please try another ID."
    end
    finder
  end

  def self.destroy(n)
    #locate product to remove by calling find method.
    #calls all returns an array with all project objects.
    #product_to_remove stores individual project object to delete
    product_to_remove = find(n)
      #create table object and remove found Product object from array and file.
    product_to_remove.delete_from_CVS_file
  end

  #sourced from http://stackoverflow.com/questions/26707169/how-to-remove-a-row-from-a-csv-with-ruby
  def delete_from_CVS_file
    #creates table object with headers
    table = CSV.table(@@data_path, headers: true)
    #uses delete_if method to delete row that matches id passed in at destory
    table.delete_if do |row|
      row[:id] == self.id
    end
    #opens csv file to write.
    File.open(@@data_path, 'w') do |csv|
      csv.write(table.to_csv)
    end
    #returns deleted product
    return self
  end

  def self.where(options={})
    if options[:brand]
      all.select {|product| product.brand == options[:brand]}
    else options[:name]
      all.select {|product| product.name == options[:name]}
    end
  end

  def update(options = {})
    updated_products = []
    table = CSV.table(@@data_path, headers: true)
    table.each do |cell|
      #Replaced instance variables with hashs because data is now in CSV.table
      #Self.id is calling the id of the Product object from find.() in the test method.
      #removed id from being updated since its a unique identifier in the CSV file
      if cell[:id] == self.id
          cell[:price] = options[:price] if options[:price]
          cell[:brand] = options[:brand] if options[:brand]
          cell[:name] = options[:name] if options[:name]
          #Need to create new product object with updated values
          updated_products = Product.create(id: cell[:id], brand: cell[:brand], name: cell[:product], price: cell[:price])
      end
    end
    #opens csv file to write.
    File.open(@@data_path, 'w') do |csv|
     csv.write(table.to_csv)
    end
    updated_products
  end
end
