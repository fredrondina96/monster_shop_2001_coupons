class Merchant::ItemOrdersController < Merchant::BaseController

  def update
    item_order = ItemOrder.find(params[:id])
    if item_order.fulfill
      flash[:success] = "#{item_order.item.name} has been fulfilled"
    else
      flash[:error] = item_order.errors.full_messages.to_sentence
    end
    redirect_to merchant_order_show_path(item_order.order)
  end
  
end
