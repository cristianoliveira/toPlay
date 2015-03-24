module UsersHelper
  def selected(menu)
    return 'selected' if menu == controller.action_name
  end

  def unread(notification_read)
    return 'read' if notification_read
    return 'unread'
  end
end
