class ProductOptionsController < InheritedResources::Base

  private

    def product_option_params
      params.require(:product_option).permit(:product_id, :option_id)
    end
end

