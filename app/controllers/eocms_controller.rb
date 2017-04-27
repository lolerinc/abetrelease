class EOCMsController < ApplicationController
  before_action :set_eocm, only: [:show, :edit, :update, :destroy]

  # GET /eocms
  # GET /eocms.json
  def index
    if(params.has_key?(:doc_id))
      @eocm = EOCM.where("eocms.document_id = ?", params[:doc_id])
      @doc = Document.where("documents.id = ?", params[:doc_id])
    else
      @eocms = EOCM.all
    end
  end

  # GET /eocms/1
  # GET /eocms/1.json
  def show
  end

  # GET /eocms/new
  def new
    @eocm = EOCM.new
  end

  # GET /eocms/1/edit
  def edit
  end

  # POST /eocms
  # POST /eocms.json
  def create
    @eocm = EOCM.new(eocm_params)

    respond_to do |format|
      if @eocm.save
        format.html { redirect_to @eocm, notice: 'EOCM was successfully created.' }
        format.json { render :show, status: :created, location: @eocm }
      else
        format.html { render :new }
        format.json { render json: @eocm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eocms/1
  # PATCH/PUT /eocms/1.json
  def update
    respond_to do |format|
      if @eocm.update(eocm_params)
        format.html { redirect_to @eocm, notice: 'EOCM was successfully updated.' }
        format.json { render :show, status: :ok, location: @eocm }
      else
        format.html { render :edit }
        format.json { render json: @eocm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eocms/1
  # DELETE /eocms/1.json
  def destroy
    @eocm.destroy
    respond_to do |format|
      format.html { redirect_to eocms_url, notice: 'EOCM was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eocm
      @eocm = EOCM.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eocm_params
      params.require(:eocm).permit(:document_id, :evaluation, :comment_outcomes, :comment_worked, :comment_changes, :comment_rec, :comment_implemented, :comment_results, :comment_additional, :comment_failed)
    end
end
