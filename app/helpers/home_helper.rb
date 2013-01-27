module HomeHelper
  def is_active_pager(requested_amount, amount)
    requested_amount.to_i == amount.to_i ? 'active' : 'non-active'
  end
end
