module SearchHelper
  def show(activerecord_object)
    begin
      link_to activerecord_object.name, activerecord_object
    rescue
      activerecord_object.name
    end
  end
end
