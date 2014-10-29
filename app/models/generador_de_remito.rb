#encoding: utf-8
# require '../lib/odf-report'

# report = ODFReport::Report.new("./plantillas/REMITO_INT_PRESENTA.odt") do |r|

#   r.add_field("FECHA_DE_IMPRESION_DEL_REMITO", "14/04/2014 12:00")
#   r.add_field("NOMBRE_DEL_ESPECTACULO", "espectáculo fruta")
#   r.add_field("PROVINCIA", "Jujuy")
#   r.add_field("REGION", "NOA")
#   r.add_field("NUMERO_DE_TRAMITE", "123")
#   r.add_field("FECHA_DE_TRAMITE", "12/04/2014 15:00")
#   r.add_field("DATOS_DEL_RESPONSABLE", "fruta")
# end

# report.generate("./result/REMITO_INT_PRESENTA.odt")

class GeneradorDeRemito

  def obtener_datos_para_remito(formulario)
    datos = OpenStruct.new(
      fecha_de_impresion_del_remito: I18n.l(Time.zone.now, format: :con_seg),
      nombre_del_espectaculo: formulario.principal.nombre,
      provincia: formulario.principal.provincia.detalle,
      region: formulario.principal.provincia.region.detalle,
      numero_de_tramite: formulario.id.to_s,
      fecha_de_tramite: I18n.l(formulario.created_at, format: :con_seg),
      datos_del_responsable: "fruta"
    )
  end

end
