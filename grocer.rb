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
      if cart[cart_index][:item] == coupons[coupons_index][:item]
        remainder = cart[cart_index][:count] % coupons[coupons_index][:num]
        couponed_item = {
          :item => "#{cart[cart_index][:item]} W/COUPON",
          :price => coupons[coupons_index][:cost] / coupons[coupons_index][:num],
          :clearance => cart[cart_index][:clearance],
          :count => cart[cart_index][:count] - remainder
        }
        cart << couponed_item
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
  cart_index = 0
  while cart_index < cart.length do
    if cart[cart_index][:clearance] == true
      clearance_savings = cart[cart_index][:price] * 0.2
      new_price = cart[cart_index][:price] - clearance_savings
      cart[cart_index][:price] = new_price.round(2)
    end
    cart_index += 1
  end
  cart
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
  consolidated_cart = consolidate_cart(cart)
  cart_after_coupons = apply_coupons(consolidated_cart, coupons)
  cart_after_clearance = apply_clearance(cart_after_coupons)
  total = 0
  cart_index = 0
  while cart_index < cart_after_clearance.length do
    total_price = cart_after_clearance[cart_index][:price] * cart_after_clearance[cart_index][:count]
    total += total_price
    cart_index += 1
  end
  if total > 100
    total_discount = total * 0.1
    total -= total_discount.round(2)
  end
  total
end
