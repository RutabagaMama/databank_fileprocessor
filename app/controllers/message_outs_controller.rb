class MessageOutsController < ApplicationController
  before_action :set_message_out, only: [:show, :edit, :update, :destroy]

  # GET /message_outs
  # GET /message_outs.json
  def index
    @message_outs = MessageOut.all
  end

  # GET /message_outs/1
  # GET /message_outs/1.json
  def show
  end

  # GET /message_outs/new
  def new
    @message_out = MessageOut.new
  end

  # GET /message_outs/1/edit
  def edit
  end

  # POST /message_outs
  # POST /message_outs.json
  def create
    @message_out = MessageOut.new(message_out_params)

    respond_to do |format|
      if @message_out.save
        format.html { redirect_to @message_out, notice: 'Message out was successfully created.' }
        format.json { render :show, status: :created, location: @message_out }
      else
        format.html { render :new }
        format.json { render json: @message_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_outs/1
  # PATCH/PUT /message_outs/1.json
  def update
    respond_to do |format|
      if @message_out.update(message_out_params)
        format.html { redirect_to @message_out, notice: 'Message out was successfully updated.' }
        format.json { render :show, status: :ok, location: @message_out }
      else
        format.html { render :edit }
        format.json { render json: @message_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_outs/1
  # DELETE /message_outs/1.json
  def destroy
    @message_out.destroy
    respond_to do |format|
      format.html { redirect_to message_outs_url, notice: 'Message out was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_out
      @message_out = MessageOut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_out_params
      params.require(:message_out).permit(:content)
    end
end
