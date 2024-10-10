class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_user_and_item_status, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_mailing_address = OrderMailingAddress.new
  end

  def create
    @order_mailing_address = OrderMailingAddress.new(order_params)
     if @order_mailing_address.valid? # rubocop:disable Layout/IndentationConsistency
        pay_item # rubocop:disable Layout/IndentationWidth
        @order_mailing_address.save
        redirect_to root_path
     else
        gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # rubocop:disable Layout/IndentationWidth
        render :index, status: :unprocessable_entity
     end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_mailing_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                  :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token]) # rubocop:disable Layout/ArgumentAlignment
  end

  def check_user_and_item_status
    if @item.sold? || current_user == @item.user # rubocop:disable Style/IfUnlessModifier,Style/GuardClause
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
