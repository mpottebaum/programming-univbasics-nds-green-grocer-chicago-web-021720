def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  cart_index = 0
  while cart_index < collection.length do
    if collection[cart_index][:item] == name
      return collection[cart_index]
    end
    cart_index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  cart_index = 0
  consolidated_cart = []
  while cart_index < cart.length do
    find_item = find_item_by_name_in_collection(cart[cart_index][:item], consolidated_cart)
    if find_item
      item_index = consolidated_cart.index(find_item)
      consolidated_cart[item_index][:count] += 1
    else
      new_item = cart[cart_index]
      new_item[:count] = 1
      consolidated_cart << new_item
    end
    cart_index += 1
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_index = 0
  while cart_index < cart.length do
    coupons_index = 0
    while coupons_index < coupons.length do
      cart_item = cart[cart_index]
      coupon_item = coupons[coupons_index]
      if cart_item[:item] == coupon_item[:item] && cart_item[:count] > coupon_item[:num]
        remainder = cart_item[:count] % coupon_item[:num]
        coupon_cart = cart_item
        coupon_cart[:item] = "#{cart[cart_index][:item]} W/COUPON"
        coupon_cart[:price] = coupon_item[:cost] / coupon_item[:num]
        coupon_cart[:count] = cart[cart_index][:count] - remainder
        cart << coupon_cart
        cart[cart_index][:count] = remainder
      end
      coupons_index += 1
    end
    cart_index += 1
  end
  cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
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
end
