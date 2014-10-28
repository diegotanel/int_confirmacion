# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141027173625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "datos_del_responsables", force: true do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datos_del_responsables", ["formulario_id"], name: "index_datos_del_responsables_on_formulario_id", using: :btree

  create_table "datos_esps", force: true do |t|
    t.integer  "formulario_id",          null: false
    t.date     "fecha_de_estreno",       null: false
    t.string   "nombre_autor",           null: false
    t.string   "nacionalidad_autor",     null: false
    t.string   "duracion_espectaculo",   null: false
    t.string   "interpretes_escena",     null: false
    t.string   "directores_espectaculo", null: false
    t.string   "sinopsis_obra",          null: false
    t.string   "pagina_web"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "foro"
    t.string   "blog"
    t.string   "youtube"
    t.string   "instagram"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datos_esps", ["formulario_id"], name: "index_datos_esps_on_formulario_id", using: :btree

  create_table "datos_esps_formatos", id: false, force: true do |t|
    t.integer "formato_id",   null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_formatos", ["formato_id", "datos_esp_id"], name: "index_datos_esps_formatos_on_formato_id_and_datos_esp_id", using: :btree

  create_table "datos_esps_gen_esps", id: false, force: true do |t|
    t.integer "gen_esp_id",   null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_gen_esps", ["gen_esp_id", "datos_esp_id"], name: "index_datos_esps_gen_esps_on_gen_esp_id_and_datos_esp_id", using: :btree

  create_table "datos_esps_publs_edad", id: false, force: true do |t|
    t.integer "publ_edad_id", null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_publs_edad", ["publ_edad_id", "datos_esp_id"], name: "index_datos_esps_publs_edad_on_publ_edad_id_and_datos_esp_id", using: :btree

  create_table "datos_esps_publs_exp", id: false, force: true do |t|
    t.integer "publ_exp_id",  null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_publs_exp", ["publ_exp_id", "datos_esp_id"], name: "index_datos_esps_publs_exp_on_publ_exp_id_and_datos_esp_id", using: :btree

  create_table "datos_grupos", force: true do |t|
    t.string   "nombre_grupo",  null: false
    t.string   "historia",      null: false
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datos_grupos", ["formulario_id"], name: "index_datos_grupos_on_formulario_id", using: :btree

  create_table "datos_tecs", force: true do |t|
    t.string   "duracion_montaje",             null: false
    t.string   "duracion_desmontaje",          null: false
    t.string   "descripcion_espacio",          null: false
    t.string   "ancho",                        null: false
    t.string   "alto",                         null: false
    t.string   "profundidad",                  null: false
    t.string   "listado_artefactos_luminicos", null: false
    t.string   "listado_sonido",               null: false
    t.string   "otros_equipamientos"
    t.string   "peso_total",                   null: false
    t.string   "volumen_total",                null: false
    t.string   "otras_necesidades"
    t.integer  "formulario_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datos_tecs", ["formulario_id"], name: "index_datos_tecs_on_formulario_id", using: :btree

  create_table "datos_tecs_esps_esps", id: false, force: true do |t|
    t.integer "esps_esp_id",  null: false
    t.integer "datos_tec_id", null: false
  end

  add_index "datos_tecs_esps_esps", ["esps_esp_id", "datos_tec_id"], name: "index_datos_tecs_esps_esps_on_esps_esp_id_and_datos_tec_id", using: :btree

  create_table "directores_en_gira", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elencos_en_gira", force: true do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elencos_en_gira", ["formulario_id"], name: "index_elencos_en_gira_on_formulario_id", using: :btree

  create_table "esps_esps", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ficha_artisticas", force: true do |t|
    t.string   "nombre_artista",   null: false
    t.string   "apellido_artista", null: false
    t.string   "rol_artista",      null: false
    t.integer  "datos_esp_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ficha_artisticas", ["datos_esp_id"], name: "index_ficha_artisticas_on_datos_esp_id", using: :btree

  create_table "formatos", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formularios", force: true do |t|
    t.integer  "user_id"
    t.integer  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formularios", ["user_id", "created_at"], name: "index_formularios_on_user_id_and_created_at", using: :btree

  create_table "gen_esps", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grupos", force: true do |t|
    t.string   "detalle",    null: false
    t.string   "codigo",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrantes_comision_directiva", force: true do |t|
    t.string   "cargo",               null: false
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.datetime "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "persona_juridica_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "integrantes_comision_directiva", ["localidad_id"], name: "index_integrantes_comision_directiva_on_localidad_id", using: :btree
  add_index "integrantes_comision_directiva", ["persona_juridica_id"], name: "index_integrantes_comision_directiva_on_persona_juridica_id", using: :btree

  create_table "integrantes_de_elenco_en_gira", force: true do |t|
    t.string   "type",                null: false
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.datetime "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "elenco_en_gira_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "integrantes_de_elenco_en_gira", ["elenco_en_gira_id"], name: "index_integrantes_de_elenco_en_gira_on_elenco_en_gira_id", using: :btree
  add_index "integrantes_de_elenco_en_gira", ["localidad_id"], name: "index_integrantes_de_elenco_en_gira_on_localidad_id", using: :btree
  add_index "integrantes_de_elenco_en_gira", ["type"], name: "index_integrantes_de_elenco_en_gira_on_type", using: :btree

  create_table "integrantes_del_esp", force: true do |t|
    t.string   "rol",                 null: false
    t.string   "nombre_integrante",   null: false
    t.string   "apellido_integrante", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localidades", force: true do |t|
    t.string   "codigo",       null: false
    t.string   "detalle",      null: false
    t.integer  "provincia_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localidades", ["provincia_id"], name: "index_localidades_on_provincia_id", using: :btree

  create_table "personas", force: true do |t|
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.datetime "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["localidad_id"], name: "index_personas_on_localidad_id", using: :btree

  create_table "personas_fisicas_e", force: true do |t|
    t.integer  "integrante_de_elenco_en_gira_id", null: false
    t.integer  "responsable_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas_fisicas_e", ["integrante_de_elenco_en_gira_id"], name: "index_personas_fisicas_e_on_integrante_de_elenco_en_gira_id", using: :btree
  add_index "personas_fisicas_e", ["responsable_id"], name: "index_personas_fisicas_e_on_responsable_id", using: :btree

  create_table "personas_fisicas_n", force: true do |t|
    t.integer  "persona_id",     null: false
    t.integer  "responsable_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas_fisicas_n", ["persona_id"], name: "index_personas_fisicas_n_on_persona_id", using: :btree
  add_index "personas_fisicas_n", ["responsable_id"], name: "index_personas_fisicas_n_on_responsable_id", using: :btree

  create_table "personas_juridicas", force: true do |t|
    t.string   "nombre_per_juridica", null: false
    t.string   "num_cuit",            null: false
    t.string   "num_per_juridica",    null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_entidad"
    t.string   "email_entidad",       null: false
    t.integer  "responsable_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas_juridicas", ["localidad_id"], name: "index_personas_juridicas_on_localidad_id", using: :btree
  add_index "personas_juridicas", ["responsable_id"], name: "index_personas_juridicas_on_responsable_id", using: :btree

  create_table "principals", force: true do |t|
    t.integer  "formulario_id", null: false
    t.integer  "localidad_id",  null: false
    t.integer  "grupo_id",      null: false
    t.string   "nombre",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "principals", ["formulario_id"], name: "index_principals_on_formulario_id", using: :btree
  add_index "principals", ["grupo_id"], name: "index_principals_on_grupo_id", using: :btree
  add_index "principals", ["localidad_id"], name: "index_principals_on_localidad_id", using: :btree

  create_table "provincias", force: true do |t|
    t.string   "codigo",     null: false
    t.string   "detalle",    null: false
    t.integer  "region_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provincias", ["region_id"], name: "index_provincias_on_region_id", using: :btree

  create_table "publs_edad", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publs_exp", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regiones", force: true do |t|
    t.string   "codigo",     null: false
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsables", force: true do |t|
    t.string   "type",                     null: false
    t.string   "detalle",                  null: false
    t.integer  "datos_del_responsable_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responsables", ["datos_del_responsable_id"], name: "index_responsables_on_datos_del_responsable_id", using: :btree
  add_index "responsables", ["type"], name: "index_responsables_on_type", using: :btree

  create_table "super_vistas", force: true do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "super_vistas", ["formulario_id"], name: "index_super_vistas_on_formulario_id", using: :btree

  create_table "tecnicos_del_esp", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",           null: false
    t.string   "last_name",      null: false
    t.string   "email",          null: false
    t.string   "password",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
