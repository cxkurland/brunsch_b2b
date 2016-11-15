module Spree
  TaxonsController.class_eval do 
    
	  def show
	    @taxon = Taxon.friendly.find(params[:id])
	    return unless @taxon

	    @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
	    taxon_ids = [@taxon.id]
	    @search = Sunspot.search(Spree::Product) do
	    	paginate(:page => params[:page] || 1, :per_page => Spree::Config[:products_per_page])
	    	with(:taxon_ids, taxon_ids)
	    	if params[:search]
	    		if params[:search][:price_range_any]
	    			any_of do
		    			params[:search][:price_range_any].each do |range|
		    				if range.include?("or")
		    					with(:price).greater_than(range.split(" or").first.gsub("CHF", "").to_f)
		    				else
			    				bound = range.split(" - ")
			    				with(:price, bound.first.gsub("CHF", "").to_f..bound.last.gsub("CHF", "").to_f)
			    			end
		    			end
		    		end
	    		end
	    	end
	    end
	    @products = @search.results
	    @taxonomies = Spree::Taxonomy.includes(root: :children)
	  end
	end
end