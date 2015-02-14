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

ActiveRecord::Schema.define(version: 20150214045012) do

  create_table "deputados", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "matricula",  limit: 255
    t.string   "url_foto",   limit: 255
    t.string   "partido",    limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "despesas", force: :cascade do |t|
    t.string   "beneficiario", limit: 255
    t.string   "cpf_cnpj",     limit: 255
    t.string   "valor",        limit: 255
    t.integer  "deputado_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "despesas", ["deputado_id"], name: "index_despesas_on_deputado_id", using: :btree

  add_foreign_key "despesas", "deputados"
end
