class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def subtract_item(item)

    if @contents[item] > 1
      @contents[item] -= 1
    else
      remove_item(item)
    end
  end

  def remove_item(item)
    @contents.delete(item)
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.merchant.coupons.each do |coupon|
      if @contents[item.id.to_s] >= coupon.quantity_required
        return (item.price * @contents[item.id.to_s]) * coupon.discout
      end
    end
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

  def discount_check(item)
    @contents[item.id.to_s]
  end

end
