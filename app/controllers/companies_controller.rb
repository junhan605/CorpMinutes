class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :show_minutes]

  # GET /companies
  # GET /companies.json
  def index
    if current_user == nil
      redirect_to destroy_user_session_path
    else
      @companies = current_user.companies
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.users = Array[current_user]
    # @directors = @company.directors
    # @company.directors.build
    @company.directors.new
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @company.users = Array[current_user]
    @directors = @company.directors
    if @directors.count == 0
        @company.directors.new
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    if company_params[:user_ids] == nil
      @company.users = Array[current_user]
    end

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    # params[:company][:existing_director_attributes] ||= {}
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /companies/1/minutes
  def show_minutes
    # @company = Company.where(id: params[:id])
    #
    # respond_to do |format|
    #   format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :state, :president, :treasure, :secretary, user_ids: [], :directors_attributes => Director.attribute_names.map(&:to_sym).push(:_destroy))
    end

    def set_directors
      @directors = Directors.where(:company_id => params[:id]).
         collect do |c|
          [c.name, c.id]
         end
    end
end
