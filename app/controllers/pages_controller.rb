class PagesController < InheritedResources::Base

  def about_view
    @info = Page.all.where(name: 'About')
  end

  def contact_view
    @info = Page.all.where(name: 'Contact')
  end

  private

    def page_params
      params.require(:page).permit(:name, :content)
    end
end
