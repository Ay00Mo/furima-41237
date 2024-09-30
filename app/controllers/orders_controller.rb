class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_user_and_item_status, only: [:index, :create]
  def index
    @order_mailing_address = OrderMailingAddress.new
  end

  def create
    @order_mailing_address = OrderMailingAddress.new(order_params)
     if @order_mailing_address.valid? # rubocop:disable Layout/IndentationConsistency
        @order_mailing_address.save # rubocop:disable Layout/IndentationWidth
        redirect_to root_path
     else
      render :index, status: :unprocessable_entity # rubocop:disable Layout/IndentationWidth
     end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_mailing_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                  :phone_number).merge(item_id: params[:item_id]) # rubocop:disable Layout/ArgumentAlignment
  end

  def check_user_and_item_status
    if @item.sold? || current_user == @item.user # rubocop:disable Style/IfUnlessModifier,Style/GuardClause
      redirect_to root_path
    end
  end
end
