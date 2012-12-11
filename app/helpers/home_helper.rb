module HomeHelper
  def is_active_pager(requested_amount, amount)
    requested_amount == amount ? 'active' : 'non-active'
  end
end
