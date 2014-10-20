module ApplicationHelper

  def selected(localidad)
    if localidad.nil?
      {}
    else
      localidad.provincia_id
    end
  end
end
