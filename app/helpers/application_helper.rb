module ApplicationHelper

  def selected(localidad)
    if localidad.nil?
      {}
    else
      localidad.provincia_id
    end
  end

  def logo
    image_tag("logosm.png", :alt => "INT", :id => 'logo')
  end
end
