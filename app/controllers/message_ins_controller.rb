class MessageInsController < ApplicationController
  before_action :set_message_in, only: [:show, :edit, :update, :destroy]

  # GET /message_ins
  # GET /message_ins.json
  def index
    @message_ins = MessageIn.all
  end

  # GET /message_ins/1
  # GET /message_ins/1.json
  def show
  end

  # GET /message_ins/new
  def new
    @message_in = MessageIn.new
  end

  # GET /message_ins/1/edit
  def edit
  end

  # POST /message_ins
  # POST /message_ins.json
  def create
    @message_in = MessageIn.new(message_in_params)

    respond_to do |format|
      if @message_in.save
        format.html { redirect_to @message_in, notice: 'Message in was successfully created.' }
        format.json { render :show, status: :created, location: @message_in }
      else
        format.html { render :new }
        format.json { render json: @message_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_ins/1
  # PATCH/PUT /message_ins/1.json
  def update
    respond_to do |format|
      if @message_in.update(message_in_params)
        format.html { redirect_to @message_in, notice: 'Message in was successfully updated.' }
        format.json { render :show, status: :ok, location: @message_in }
      else
        format.html { render :edit }
        format.json { render json: @message_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_ins/1
  # DELETE /message_ins/1.json
  def destroy
    @message_in.destroy
    respond_to do |format|
      format.html { redirect_to message_ins_url, notice: 'Message in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_in
      @message_in = MessageIn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_in_params
      params.require(:message_in).permit(:content)
    end
end
