module ApplicationHelper
  def format_ym(time)
    time.strftime('%Y/%m')
  end

  def format_ymd(time)
    time.strftime('%Y.%m.%d')
  end
end
