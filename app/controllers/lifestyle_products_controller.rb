class lifestyleProductsController < InheritedResources::Base

  private

    def lifestyle_product_params
      params.require(:lifestyle_product).permit(:lifestyle_id, :product_id)
    end
end
