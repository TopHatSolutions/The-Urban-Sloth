class LineItemsController < InheritedResources::Base

  private

    def line_item_params
      params.require(:line_item).permit(:product, :price, :quantity, :order_id)
    end
end

