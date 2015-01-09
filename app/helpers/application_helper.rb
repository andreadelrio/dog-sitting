module ApplicationHelper
  def alert_type flash_type
    case flash_type
      when :success
        "alert-type-success"
      when :error
        "alert-type-danger"
      when :alert
        "alert-type-warning"
      when :notice
        "alert-type-info"
      else
        flash_type.to_s
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def home?
    (params[:action] == "home" && params[:controller] == "providers")
  end



end
