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

ActiveRecord::Schema.define(version: 20141007152654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actores", force: true do |t|
    t.string   "nombre_actor",        null: false
    t.string   "apellido_actor",      null: false
    t.string   "num_de_cuil_cuit",    null: false
    t.date     "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.string   "actor_provincia",     null: false
    t.string   "actor_localidad",     null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "elencos_en_gira_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actores", ["elencos_en_gira_id"], name: "index_actores_on_elencos_en_gira_id", using: :btree

  create_table "condiciones", force: true do |t|
    t.string   "codigo",     null: false
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condiciones_principals", id: false, force: true do |t|
    t.integer "condicion_id", null: false
    t.integer "principal_id", null: false
  end

  add_index "condiciones_principals", ["condicion_id", "principal_id"], name: "index_condiciones_principals_on_condicion_id_and_principal_id", using: :btree

  create_table "directores", force: true do |t|
    t.string   "nombre_director",     null: false
    t.string   "apellido_director",   null: false
    t.string   "num_de_cuil_cuit",    null: false
    t.date     "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.string   "director_localidad",  null: false
    t.string   "director_provincia",  null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "elencos_en_gira_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directores", ["elencos_en_gira_id"], name: "index_directores_on_elencos_en_gira_id", using: :btree

  create_table "elencos_en_giras", force: true do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elencos_en_giras", ["formulario_id"], name: "index_elencos_en_giras_on_formulario_id", using: :btree

  create_table "formularios", force: true do |t|
    t.integer  "user_id"
    t.integer  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formularios", ["user_id", "created_at"], name: "index_formularios_on_user_id_and_created_at", using: :btree

  create_table "grupos", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localidades", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "principals", force: true do |t|
    t.integer  "formulario_id", null: false
    t.integer  "provincia_id",  null: false
    t.integer  "localidad_id",  null: false
    t.integer  "grupo_id",      null: false
    t.string   "nombre",        null: false
    t.integer  "registro_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "principals", ["formulario_id"], name: "index_principals_on_formulario_id", using: :btree
  add_index "principals", ["grupo_id"], name: "index_principals_on_grupo_id", using: :btree
  add_index "principals", ["localidad_id"], name: "index_principals_on_localidad_id", using: :btree
  add_index "principals", ["provincia_id"], name: "index_principals_on_provincia_id", using: :btree
  add_index "principals", ["registro_id"], name: "index_principals_on_registro_id", using: :btree

  create_table "provincias", force: true do |t|
    t.string   "detalle",    null: false
    t.integer  "region_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provincias", ["region_id"], name: "index_provincias_on_region_id", using: :btree

  create_table "regiones", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registros", force: true do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tecnicos", force: true do |t|
    t.string   "nombre_tecnico",      null: false
    t.string   "apellido_tecnico",    null: false
    t.string   "num_de_cuil_cuit",    null: false
    t.date     "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.string   "tecnico_localidad",   null: false
    t.string   "tecnico_provincia",   null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "elencos_en_gira_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tecnicos", ["elencos_en_gira_id"], name: "index_tecnicos_on_elencos_en_gira_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",           null: false
    t.string   "email",          null: false
    t.string   "password",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
