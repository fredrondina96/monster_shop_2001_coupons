class Merchant::OrdersController < Merchant::BaseController

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.permit(:id, :name,:description,:price,:inventory,:image, :status)
  end
end