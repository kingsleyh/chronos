module TimesheetsHelper

  def colour_map
    {
        :red => 'important',
        :green => 'success',
        :gray => 'default',
        :blue => 'info',
        :amber => 'warning',

    }
  end

  def labelize(value,colour=:blue)
    (!value.nil? && value > 0) ? raw('<span class="label label-' + colour_map[colour] + '">' + value.to_s + '</span>') : value
  end

  def labelize_status(status)
    status_map = {
        'new' => colour_map[:blue],
        'submitted' => colour_map[:amber],
        'approved' => colour_map[:green],
        'processed' => colour_map[:green],
        'rejected' => colour_map[:red]
    }
    raw('<span class="label label-' + status_map[status] + '">' + status + '</span>')
  end

end
