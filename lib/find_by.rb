class Module
  def create_finder_methods(*attributes)
  # Your code goes here!
  # Hint: Remember attr_reader and class_eval
  	attributes.each do |attribute|
      #Use %Q to interporlate and the create new methods
  		creates_find_by_brand_or_name = %Q{
  			def self.find_by_#{attribute}(brand_or_name)
  				self.all.each do |product|
  					if product.#{attribute} == brand_or_name
  						return product
  					end
  				end
  			end
  		}
  		class_eval(creates_find_by_brand_or_name)
  	end
  end
end
