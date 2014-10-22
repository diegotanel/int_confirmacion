#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach(Rails.root + 'config/INT_regiones.csv', headers: true) do |row|
  Region.skip_callback(:create)
  @reg = Region.new(codigo: row[1].squish, detalle: row[2].squish)
  @reg.save(:validate => false)
  Region.set_callback(:create)
end

CSV.foreach(Rails.root + 'config/INT_provincias.csv', headers: true) do |row|
  Provincia.skip_callback(:create)
  @reg = Region.find_by(codigo: row[3].squish)
  @reg.provincias.create!(codigo: row[1].squish, detalle: row[2].squish)
  Provincia.set_callback(:create)
end

CSV.foreach(Rails.root + 'config/INT_localidades.csv', headers: true) do |row|
  Localidad.skip_callback(:create)
  @prov = Provincia.find_by(codigo: row[3].squish)
  @prov.localidades.create!(codigo: row[0].squish, detalle: row[1].squish)
  Localidad.set_callback(:create)
end

Grupo.create!(codigo: "a", detalle: "Grupo")
Grupo.create!(codigo: "b", detalle: "Espectáculo concertado")