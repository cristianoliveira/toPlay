module ApplicationHelper

    def show_menu
        return current_page?(root_url) || current_page?(cursos_path) || current_page?(sobre_path)
    end
end
