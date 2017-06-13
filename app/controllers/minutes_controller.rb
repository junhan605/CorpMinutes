class MinutesController < InheritedResources::Base


  def index
    @minutes = Minute.all.where(:company_id => params[:company_id])
    @company = Company.all.where(:id => params[:company_id]).first
  end

  def new
    @minute = Minute.new
    @company_id = params[:company_id]
    @company = Company.all.where(id: params[:company_id]).first
    @minute.company_id = params[:company_id]
  end

  def create
    @company_id = params[:minute][:company_id]
    @company = Company.all.where(id: params[:minute][:company_id]).first

    @minute = Minute.new(minute_params)
    @minute.company_id = params[:minute][:company_id]

    respond_to do |format|
      if @minute.save
        format.html { redirect_to company_minute_path(@minute, :company_id => @company_id) , notice: 'Minute was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @company_id = params[:company_id]
    @company = Company.all.where(id: params[:company_id]).first
    @minute = Minute.all.where(id: params[:id]).first
  end


  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    # params[:company][:existing_director_attributes] ||= {}
    @minute = Minute.find(params[:id])

    respond_to do |format|
      if @minute.update_attributes(minute_params)
        format.html { redirect_to company_minute_path(@minute, :company_id => @company_id), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def download_minute
    @minute = Minute.find(params[:id])
    @company_id = @minute.company_id

    respond_to do |format|
      format.html
      format.pdf do
        # pdf = Prawn::Document.new
        rende :pdf =>"BBB.pdf",
               :disposition => "inline"

        # send_data pdf.render, filename: "#{@minute.name}.pdf",
        #   type: 'application/pdf'

        # render pdf: "#{@minute.name}.pdf"   # Excluding ".pdf" extension.
      end
    end
  end

  private

    def minute_params
      params.require(:minute).permit(:minute_type, :location, :other_party, :escriibe_property, :company_id)
    end
end
