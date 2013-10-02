module CustomersHelper

  def status_class(status)
    status ? 's_green' : 's_gray'
  end

end
