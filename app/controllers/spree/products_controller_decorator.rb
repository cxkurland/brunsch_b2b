module Spree
  ProductsController.class_eval do 
    
	  def index
	    @searcher = build_searcher(params.merge(include_images: true))
	    @taxonomies = Spree::Taxonomy.includes(root: :children)
	    @search = Sunspot.search(Spree::Product) do
	    	
       	 paginate(:page => params[:page] || 1, :per_page => params[:per_page] ? params[:per_page] : 15)	
	    	# paginate(:page => params[:page] || 1, :per_page => Spree::Config[:products_per_page])
	    	unless params[:keywords].blank?
	    		any do
            fulltext "*#{params[:keywords]}*"
            fulltext params[:keywords]
          end
	    	end
	    	unless params[:taxon].blank?
	    		with(:taxon_ids, [params[:taxon]])
	    	end
	    end
	    @products = @search.results
	  end
	end
end