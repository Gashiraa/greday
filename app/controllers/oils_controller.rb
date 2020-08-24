class OilsController < ApplicationController
  before_action :set_oil, only: [:show, :edit, :update, :destroy]

  # GET /oils
  # GET /oils.json
  def index
    @oils = Oil.all
  end

  # GET /oils/1
  # GET /oils/1.json
  def show
  end

  # GET /oils/new
  def new
    @oil = Oil.new
  end

  # GET /oils/1/edit
  def edit
  end

  # POST /oils
  # POST /oils.json
  def create
    @oil = Oil.new(oil_params)

    respond_to do |format|
      if @oil.save
        format.html {redirect_to request.env["HTTP_REFERER"], notice: 'Oil was successfully created.' }
        format.json { render :show, status: :created, location: @oil }
      else
        format.html { render :new }
        format.json { render json: @oil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oils/1
  # PATCH/PUT /oils/1.json
  def update
    respond_to do |format|
      if @oil.update(oil_params)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: 'Oil was successfully updated.' }
        format.json { render :show, status: :ok, location: @oil }
      else
        format.html { render :edit }
        format.json { render json: @oil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oils/1
  # DELETE /oils/1.json
  def destroy
    @oil.destroy
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: 'Oil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oil
      @oil = Oil.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def oil_params
      params.require(:oil).permit(:machine_id, :category, :oil_type, :quantity)
    end
end
