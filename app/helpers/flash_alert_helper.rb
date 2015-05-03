module FlashAlertHelper

	def flash_alert_tag
    if flash[:message]
      "<div id=\"flash-alert-default\" hidden>#{flash[:message]}</div>"
    elsif flash[:success]
      "<div id=\"flash-alert-success\" hidden>#{flash[:success]}</div>"
    elsif flash[:error]
      "<div id=\"flash-alert-error\" hidden>#{flash[:error]}</div>"
    end
  end
	
end
