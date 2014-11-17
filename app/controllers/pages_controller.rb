class PagesController < InheritedResources::Base

  def about_view
    @info = Page.find_by(name: 'About')
  end

  def contact_view
    @info = Page.find_by(name: 'Contact')
  end

  private

    def page_params
      params.require(:page).permit(:name, :content)
    end
end
