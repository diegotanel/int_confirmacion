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

ActiveRecord::Schema.define(version: 20141001153141) do

  create_table "condiciones", force: true do |t|
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formularios", force: true do |t|
    t.integer  "principal_id"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formularios", ["principal_id"], name: "index_formularios_on_principal_id"
  add_index "formularios", ["user_id", "created_at"], name: "index_formularios_on_user_id_and_created_at"

  create_table "grupos", force: true do |t|
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localidades", force: true do |t|
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "principals", force: true do |t|
    t.integer  "provincia_id"
    t.integer  "localidad_id"
    t.integer  "grupo_id"
    t.integer  "condicion_id"
    t.string   "nombre"
    t.string   "detalle"
    t.integer  "registro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "principals", ["condicion_id"], name: "index_principals_on_condicion_id"
  add_index "principals", ["grupo_id"], name: "index_principals_on_grupo_id"
  add_index "principals", ["localidad_id"], name: "index_principals_on_localidad_id"
  add_index "principals", ["provincia_id"], name: "index_principals_on_provincia_id"
  add_index "principals", ["registro_id"], name: "index_principals_on_registro_id"

  create_table "provincias", force: true do |t|
    t.string   "detalle"
    t.integer  "region_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provincias", ["region_id"], name: "index_provincias_on_region_id"

  create_table "regiones", force: true do |t|
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registros", force: true do |t|
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
