module Spree
  ProductsHelper.class_eval do

    def cache_key_for_products
      count = @products.count
       max_updated_at = @products.collect(&:updated_at).max.to_s

      # max_updated_at = @products.collect(&:updated_at).max.to_s(:number)
      # max_updated_at = (@products.maximum(:updated_at) || Date.today).to_s(:number)
      products_cache_keys = "spree/products/all-#{params[:page]}-#{max_updated_at}-#{count}-#{params[:view]}-#{params[:per_page]}"
      (common_product_cache_keys + [products_cache_keys]).compact.join("/")
    end

    def cache_key_for_product(product = @product)
      (common_product_cache_keys + [product.cache_key, product.possible_promotions] + [params[:view]]).compact.join("/")
    end

  end
end