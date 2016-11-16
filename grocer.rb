def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |food, food_info|
      if new_hash[food]
        new_hash[food][:count] += 1
      else
        new_hash[food] = food_info
        new_hash[food][:count] = 1
      end
    end
  end
new_hash
end

def apply_coupons(cart, coupons)
coupons.each do |coupon|
  food = coupon[:item]
  if cart[food] && cart[food][:count] >= coupon[:num]
    if cart["#{food} W/COUPON"]
      cart["#{food} W/COUPON"][:count] += 1
    else cart["#{food} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
         cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
    end
    cart[food][:count] = cart[food][:count] - coupon[:num]
  end
end
cart
end

def apply_clearance(cart)
  cart.each do |food, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cost = 0
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  final_cart.each do |food, info|
    cost += (info[:price] * info[:count]).round(2)
  end
  cost = cost * 0.9 if cost > 100
  cost
end
