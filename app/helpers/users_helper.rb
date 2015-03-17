module UsersHelper
  def selected(menu)
    return 'selected' if menu == controller.action_name
  end
end
