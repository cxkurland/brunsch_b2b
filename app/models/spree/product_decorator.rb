module Spree
	Product.class_eval do 
		

    searchable do
      text :name
      text :description

      float :price

      string :taxon_name, references: Spree::Taxon, multiple: true do
        taxons.where.not(name: "categories").collect(&:name).flatten
      end

      integer :taxon_ids, references: Spree::Taxon, multiple: true do
        taxons.collect { |t| t.self_and_ancestors.map(&:id) }.flatten
      end

      string :product_property_name, references: Spree::ProductProperty, multiple: true do
        product_properties.collect { |p| p.value }.flatten
      end
    end

  end
end