class DirectorsController < InheritedResources::Base

  private

    def director_params
      params.require(:director).permit(:name, :company_attributes => [:id])
    end
end
