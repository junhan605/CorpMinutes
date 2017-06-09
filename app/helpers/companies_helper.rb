module CompaniesHelper
  def fields_for_director(director, &block)
    prefix = director.new_record? ? 'new' : 'existing'
    fields_for("company[#{prefix}_director_attributes][]", director, &block)
  end

  def add_director_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :directors, :partial => 'director', :object => Director.new
    end
  end
end
