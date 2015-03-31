ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span :asdasd
    #      span I18n.t("active_admin.dashboard_welcome.welcome")
    #      small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Todos os Conteúdos" do
          ul do
            Course.all.map do |course|
              li course.name
              ul do
                Subject.where(course_id: course.id).map do |subject|
                  li link_to subject.name, admin_subject_levels_path(subject) 
                  ul do
                    Level.where(subject_id: subject.id).order(:position).map do |level|
                      li link_to level.name, admin_level_topics_path(level)
                    end
                  end
                end
              end
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
