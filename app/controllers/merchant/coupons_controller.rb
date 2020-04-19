class Merchant::CouponsController < Merchant::BaseController

  def new

  end

  def edit
    @coupon = Coupon.find(params[:coupon_id])
  end

  def destroy
    coupon = Coupon.find(params[:coupon_id])
      if coupon.destroy
        flash[:success] = "Coupon Deleted"
      else
        flash[:error] = coupon.errors.full_messages.to_sentence
      end
    redirect_to "/merchant"
  end

  def create
    merchant = Merchant.find(current_user.merchant.id)
    @coupon = merchant.coupons.new(coupon_params)
      if @coupon.save
        flash[:sucess] = "#{@coupon.name} has been added"
        redirect_to "/merchant"
      else
        flash.now[:error] = @coupon.errors.full_messages.to_sentence
        render :new
      end
  end

  def update
    @coupon = Coupon.find(params[:coupon_id])
      if @coupon.update(coupon_params)
        flash[:sucess] = "#{@coupon.name} has been updated"
        redirect_to "/merchant"
      else
        flash.now[:error] = @coupon.errors.full_messages.to_sentence
        render :edit
      end
  end

  private

  def coupon_params
    params.permit(:name,:quantity_required,:percent_off)
  end
end
