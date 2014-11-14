class OptionsController < InheritedResources::Base

  private

    def option_params
      params.require(:option).permit(:option_type, :option_value, :option_price)
    end
end

