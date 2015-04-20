module UsersHelper
  def selected(menu)
    return 'selected' if menu == controller.action_name
  end

  def unread(notification_read)
    return 'read' if notification_read
    return 'unread'
  end

  def link_new_session(content , options = {})
    link_to content, new_user_session_path, { data: { reveal_ajax: true, reveal_id: 'login_box' }}.merge(options)
  end
end
