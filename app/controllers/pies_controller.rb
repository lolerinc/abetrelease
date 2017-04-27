class PIEsController < ApplicationController
  before_action :set_pie, only: [:show, :edit, :update, :destroy]

  # GET /pies
  # GET /pies.json
  def index
    if(params.has_key?(:doc_id))
      @pie = PIE.where("pies.document_id = ?", params[:doc_id])
      @doc = Document.where("documents.id = ?", params[:doc_id])
    else
      @pies = PIE.all
    end
  end

  # GET /pies/1
  # GET /pies/1.json
  def show
  end

  # GET /pies/new
  def new
    @pie = PIE.new
  end

  # GET /pies/1/edit
  def edit
  end

  # POST /pies
  # POST /pies.json
  def create
    @pie = PIE.new(pie_params)

    respond_to do |format|
      if @pie.save
        format.html { redirect_to @pie, notice: 'PIE was successfully created.' }
        format.json { render :show, status: :created, location: @pie }
      else
        format.html { render :new }
        format.json { render json: @pie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pies/1
  # PATCH/PUT /pies/1.json
  def update
    respond_to do |format|
      if @pie.update(pie_params)
        format.html { redirect_to @pie, notice: 'PIE was successfully updated.' }
        format.json { render :show, status: :ok, location: @pie }
      else
        format.html { render :edit }
        format.json { render json: @pie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pies/1
  # DELETE /pies/1.json
  def destroy
    @pie.destroy
    respond_to do |format|
      format.html { redirect_to pies_url, notice: 'PIE was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pie
      @pie = PIE.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pie_params
      params.require(:pie).permit(:document_id, :name, :abet_outcome, :description, :tpercent, :tscore, :rpercent, :rscore, :calculation)
    end
end
