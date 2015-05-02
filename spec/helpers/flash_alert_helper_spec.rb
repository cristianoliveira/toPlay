require 'rails_helper'

describe FlashAlertHelper, :type => :helper do

	it "no flash message" do
    expect(flash_alert_tag).to be_nil
	end

	it "have a message" do
	  flash[:message] = "test"
    expect(flash_alert_tag).to be_eql "<div id=\"flash-alert-default\" hidden>#{flash[:message]}</div>"
  end

end
