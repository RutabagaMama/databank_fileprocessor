class NestedItemsController < ApplicationController
  before_action :set_nested_item, only: [:show, :edit, :update, :destroy]

  # GET /nested_items
  # GET /nested_items.json
  def index
    @nested_items = NestedItem.all
  end

  # GET /nested_items/1
  # GET /nested_items/1.json
  def show
  end

  # GET /nested_items/new
  def new
    @nested_item = NestedItem.new
  end

  # GET /nested_items/1/edit
  def edit
  end

  # POST /nested_items
  # POST /nested_items.json
  def create
    @nested_item = NestedItem.new(nested_item_params)

    respond_to do |format|
      if @nested_item.save
        format.html { redirect_to @nested_item, notice: 'Nested item was successfully created.' }
        format.json { render :show, status: :created, location: @nested_item }
      else
        format.html { render :new }
        format.json { render json: @nested_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nested_items/1
  # PATCH/PUT /nested_items/1.json
  def update
    respond_to do |format|
      if @nested_item.update(nested_item_params)
        format.html { redirect_to @nested_item, notice: 'Nested item was successfully updated.' }
        format.json { render :show, status: :ok, location: @nested_item }
      else
        format.html { render :edit }
        format.json { render json: @nested_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nested_items/1
  # DELETE /nested_items/1.json
  def destroy
    @nested_item.destroy
    respond_to do |format|
      format.html { redirect_to nested_items_url, notice: 'Nested item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nested_item
      @nested_item = NestedItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nested_item_params
      params.require(:nested_item).permit(:task_id, :dataset_id, :datafile_id, :tmp_path, :item_path, :item_name, :size, :is_directory)
    end
end
