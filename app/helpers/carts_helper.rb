module CartsHelper
  def add_to_cart type, quantity, id
    shopping_cart = session[:shopping_cart] ||= []
    flag = true

    shopping_cart.each_with_index do |item, key|
      if item["bill_detailable_type"].eql?(type) && item["bill_detailable_id"].eql?(id)
        shopping_cart[key]["count"] = shopping_cart[key]["count"].to_i + quantity.to_i
        flag = false
        break
      end
    end

    shopping_cart << {bill_detailable_type: type, bill_detailable_id: id, count: quantity} if flag
    session[:shopping_cart] = shopping_cart
  end

  def update_cart type, quantity, id
    shopping_cart = session[:shopping_cart] ||= []

    shopping_cart.each_with_index do |item, key|
      if item["bill_detailable_type"].eql?(type) && item["bill_detailable_id"].eql?(id)
        shopping_cart[key]["count"] = quantity.to_i
        flag = false
        break
      end
    end

    session[:shopping_cart] = shopping_cart
  end

  def destroy_cart type, id
    shopping_cart = session[:shopping_cart] ||= []
    shopping_cart.delete_if {|item| item["bill_detailable_type"].eql?(type) && item["bill_detailable_id"].eql?(id)}
    session[:shopping_cart] = shopping_cart
  end
end
