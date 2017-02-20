module ApplicationHelper

    def glyphicon name
        "<span class=\"glyphicon glyphicon-#{name}\" aria-hidden=\"true\"></span>".html_safe
    end


    def tags tags
      return nil unless tags
      html = ""
      tags.split(';').each { |tag| html += "<span class=\"label label-info\">#{tag}</span>" }
      html.html_safe
    end

end
