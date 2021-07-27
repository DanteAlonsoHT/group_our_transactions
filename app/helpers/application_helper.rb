module ApplicationHelper
  def calculate_money(investor, money_str, money_price_today, comparador)
    total_amount = 0
    all_money = Investment.all.where("user_id = ? and crypto = ? and group_id #{comparador} 5", investor.id, money_str)
    all_money&.each do |money|
      total_amount += money.amount * money_price_today
    end
    total_amount
  end

  def calculate_all_money(money_str, money_price_today)
    total_amount = 0
    all_money = Investment.all.where('crypto = ?', money_str)
    all_money&.each do |money|
      total_amount += money.amount * money_price_today
    end
    total_amount
  end

  def total_amount_internal(user)
    @total_amount = 0
    @total_amount = calculate_money(user, 'Bitcoin', 35_000, '!=') + calculate_money(user, 'Ethereum', 2027, '!=') +
                    calculate_money(user, 'XRP', 0.64, '!=') + calculate_money(user, 'Dogecoin', 0.61, '!=') +
                    calculate_money(user, 'USD (no crypto)', 1, '!=')
    (@total_amount).round(2)
  end

  def total_amount_external(user)
    @total_amount = 0
    @total_amount = calculate_money(user, 'Bitcoin', 35_000, '=') + calculate_money(user, 'Ethereum', 2027, '=') +
                    calculate_money(user, 'XRP', 0.64, '=') + calculate_money(user, 'Dogecoin', 0.61, '=') +
                    calculate_money(user, 'USD (no crypto)', 1, '=')
    (@total_amount).round(2)
  end

  def total_amount_all
    @total_amount = 0
    @total_amount = calculate_all_money('Bitcoin', 35_000) + calculate_all_money('Ethereum', 2027) +
                    calculate_all_money('XRP', 0.64) + calculate_all_money('Dogecoin', 0.61) +
                    calculate_all_money('USD (no crypto)', 1)
    (@total_amount).round(2)
  end
end
