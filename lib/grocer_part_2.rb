require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_items = cart.each_with_object([]) do |cart_item,temp|
    coupons.each do |coupon_item|
      if cart_item[:item] == coupon_item[:item]
        temp << {
        :item => cart_item[:item] + " W/COUPON",
        :price => coupon_item[:cost] / coupon_item[:num],
        :clearance => cart_item[:clearance],
        :count => cart_item[:count] - (cart_item[:count] % coupon_item[:num]),
        }
        cart_item[:count] = cart_item[:count] % coupon_item[:num]
      end
    end
  end
  coupon_items.each do |item|
    cart << item
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.map do |item|
    if item[:clearance] == true
      item[:price] = (item[:price] * 0.8).round(2)
    end
    item
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  total = 0
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |item|
    total += (item[:price] * item[:count])
  end

  if total > 100
    grand_total = (total * 0.9).round(2)
  else
    grand_total = total
  end

  grand_total

end
