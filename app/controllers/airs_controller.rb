class AIRsController < ApplicationController
  before_action :set_air, only: [:show, :edit, :update, :destroy]

  # GET /airs
  # GET /airs.json
  def index
    if(params.has_key?(:doc_id))
      @air = AIR.where("airs.document_id = ?", params[:doc_id])
      @doc = Document.where("documents.id = ?", params[:doc_id])
    else
      @airs = AIR.all
    end
  end

  # GET /airs/1
  # GET /airs/1.json
  def show
  end

  # GET /airs/new
  def new
    @air = AIR.new
  end

  # GET /airs/1/edit
  def edit
  end

  # POST /airs
  # POST /airs.json
  def create
    @air = AIR.new(air_params)

    respond_to do |format|
      if @air.save
        format.html { redirect_to @air, notice: 'AIR was successfully created.' }
        format.json { render :show, status: :created, location: @air }
      else
        format.html { render :new }
        format.json { render json: @air.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airs/1
  # PATCH/PUT /airs/1.json
  def update
    respond_to do |format|
      if @air.update(air_params)
        format.html { redirect_to @air, notice: 'AIR was successfully updated.' }
        format.json { render :show, status: :ok, location: @air }
      else
        format.html { render :edit }
        format.json { render json: @air.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airs/1
  # DELETE /airs/1.json
  def destroy
    @air.destroy
    respond_to do |format|
      format.html { redirect_to airs_url, notice: 'AIR was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_air
      @air = AIR.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def air_params
      params.require(:air).permit(:document_id, :name, :assignee1, :assignee2, :assignee3, :assignee4, :meetingName, :meetingDate, :analysis, :taken, :conclusion, :abetOutcome)
    end
end
