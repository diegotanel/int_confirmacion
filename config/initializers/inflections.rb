# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections do |inflect|
	inflect.irregular 'error', 'errores'
	inflect.irregular 'formulario', 'formularios'
	inflect.irregular 'provincia', 'provincias'
	inflect.irregular 'region', 'regiones'
	inflect.irregular 'localidad', 'localidades'
	inflect.irregular 'grupo', 'grupos'
	inflect.irregular 'condicion', 'condiciones'
	inflect.irregular 'registro', 'registros'
	inflect.irregular 'actor', 'actores'
	inflect.irregular 'director', 'directores'
	inflect.irregular 'tecnico', 'tecnicos'
	inflect.irregular 'elenco_en_gira', 'elencos_en_gira'
	inflect.irregular 'integrante_de_elenco_en_gira', 'integrantes_de_elenco_en_gira'
	inflect.irregular 'formato', 'formatos'
	inflect.irregular 'publico_por_edad', 'publicos_por_edad'
	inflect.irregular 'publico_por_experiencia', 'publicos_por_experiencia'
	inflect.irregular 'responsable', 'responsables'
	inflect.irregular 'generos_espectaculo', 'generos_espectaculos'
	inflect.irregular 'ficha_artistica', 'ficha_artisticas'
	inflect.irregular 'espacios_espectaculo', 'espacios_espectaculos'
	inflect.irregular 'datos_tecnicos_del_espectaculo', 'datos_tecnicos_del_espectaculos'
	inflect.irregular 'datos_del_responsable', 'datos_del_responsables'
	inflect.irregular 'datos:del_espectaculo', 'datos_del_espectaculos'
	inflect.irregular 'datos_grupo', 'datos_grupos'

end
