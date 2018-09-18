class PeeksController < ApplicationController
  before_action :set_peek, only: [:show, :edit, :update, :destroy]

  # GET /peeks
  # GET /peeks.json
  def index
    @peeks = Peek.all
  end

  # GET /peeks/1
  # GET /peeks/1.json
  def show
  end

  # GET /peeks/new
  def new
    @peek = Peek.new
  end

  # GET /peeks/1/edit
  def edit
  end

  # POST /peeks
  # POST /peeks.json
  def create
    @peek = Peek.new(peek_params)

    respond_to do |format|
      if @peek.save
        format.html { redirect_to @peek, notice: 'Peek was successfully created.' }
        format.json { render :show, status: :created, location: @peek }
      else
        format.html { render :new }
        format.json { render json: @peek.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /peeks/1
  # PATCH/PUT /peeks/1.json
  def update
    respond_to do |format|
      if @peek.update(peek_params)
        format.html { redirect_to @peek, notice: 'Peek was successfully updated.' }
        format.json { render :show, status: :ok, location: @peek }
      else
        format.html { render :edit }
        format.json { render json: @peek.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /peeks/1
  # DELETE /peeks/1.json
  def destroy
    @peek.destroy
    respond_to do |format|
      format.html { redirect_to peeks_url, notice: 'Peek was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peek
      @peek = Peek.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def peek_params
      params.require(:peek).permit(:task_id, :datafile_id, :peek_type, :peek_text)
    end
end
