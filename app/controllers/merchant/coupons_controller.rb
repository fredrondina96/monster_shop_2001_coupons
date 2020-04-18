class Merchant::CouponsController < Merchant::BaseController

  def new

  end

  def index

  end

  def create
    merchant = Merchant.find(current_user.merchant.id)
    @coupon = merchant.coupons.new(coupon_params)
    if @coupon.save
      flash[:sucess] = "#{@coupon.name} has been added"
      redirect_to "/merchant"
    else
      flash.now[:error] = "Something went wrong, try again"
      render :new
    end
  end

  private

  def coupon_params
    params.permit(:name,:quantity_required,:percent_off)
  end
end
