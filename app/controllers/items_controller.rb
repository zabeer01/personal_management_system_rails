class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :set_categories, only: %i[ new edit ]

  # GET /items or /items.json
  def index
    @items = Item.all

  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.field_details.build
  end

  # GET /items/1/edit
  def edit
    @item.field_details.build
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    @item.user_id = current_user.id
    @item.save!
    if params[:fieldDetails]
      params[:fieldDetails].each do |key, value|
        field_detail = @item.field_details.build(field_name: value[:field_name], field_val: value[:field_val])
        field_detail.item_id = @item.id  # Set the item_id for each field
        field_detail.save! 
      end
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update

    @item = Item.find(params[:id])
  
    @item.field_details.destroy_all
   # Extract and build fieldDetails from the incoming parameters
   if params[:fieldDetails]
     params[:fieldDetails].each do |key, value|
       field_detail = @item.field_details.build(field_name: value[:field_name], field_val: value[:field_val])
       field_detail.item_id = @item.id  # Set the item_id for each field
       field_detail.save! 
     end
   end
   filtered_params = item_params.except(:field_details_attributes)
   respond_to do |format|
     if @item.update(filtered_params)
       format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
       format.json { render :show, status: :ok, location: @item }
     else
       format.html { render :edit, status: :unprocessable_entity }
       format.json { render json: @item.errors, status: :unprocessable_entity }
     end
   end
 end


  # DELETE /items/1 or /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.field_details.destroy_all
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end
  
  def collections
    @items = current_user.items.group_by(&:category) # Fetch items for the current user and group by category
  end
  
  def add_to_collection
    @item = Item.find(params[:id])
    unless current_user.items.include?(@item)
      current_user.items << @item
    end
    respond_to do |format|
      format.html { redirect_to item_path(@item), notice: 'Item was successfully added to your collection.' }
      format.json { render json: { message: 'Item added to collection' }, status: :ok }
    end
  end

  def remove_from_collection
    @item = Item.find(params[:id])
    # Assuming current_user is available and represents the logged-in user
    user_item = current_user.user_items.find_by(item_id: @item.id)
    user_item.destroy if user_item

    respond_to do |format|
      format.html { redirect_to item_path(@item), notice: 'Item was successfully removed from your collection.' }
      format.json { render json: { message: 'Item removed from collection' }, status: :ok }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    
    def authorize_user!
      unless current_user.admin? || @item.user == current_user
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def set_categories
      @categories = Category.all
    end
    def item_params
      params.require(:item).permit(:name, :category, :details, :user_id, :image_url, field_details_attributes: [:id, :item_id, :field_name, :field_val,  :_destroy])
    end
end
