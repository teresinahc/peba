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

ActiveRecord::Schema.define(version: 20160924193748) do

  create_table "deputados", force: :cascade do |t|
    t.string   "nome",                 limit: 255
    t.string   "matricula",            limit: 255
    t.string   "url_foto",             limit: 255
    t.string   "partido",              limit: 255
    t.string   "email",                limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "uf",                   limit: 255
    t.integer  "id_cadastro",          limit: 4
    t.string   "nome_parlamentar",     limit: 255
    t.integer  "total_votos",          limit: 4
    t.string   "situacao_candidatura", limit: 255
    t.float    "porcentagem_votos",    limit: 24
  end

  create_table "despesas", force: :cascade do |t|
    t.string   "matricula",                  limit: 255
    t.string   "beneficiario",               limit: 255
    t.date     "data_emissao"
    t.string   "valor_liquido",              limit: 255
    t.string   "cpf_cnpj",                   limit: 255
    t.integer  "num_mes",                    limit: 4
    t.integer  "num_ano",                    limit: 4
    t.integer  "num_parcela",                limit: 4
    t.integer  "id_cadastro",                limit: 4
    t.integer  "deputado_id",                limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "descricao",                  limit: 255
    t.string   "nome_parlamentar",           limit: 255
    t.string   "valor_documento",            limit: 255
    t.string   "valor_glosa",                limit: 255
    t.integer  "num_lote",                   limit: 4
    t.integer  "num_ressarcimento",          limit: 4
    t.integer  "num_sub_cota",               limit: 4
    t.integer  "num_especificacao_sub_cota", limit: 4
    t.string   "numero",                     limit: 255
    t.string   "url_recibo",                 limit: 255
    t.integer  "ide_documento",              limit: 4
    t.integer  "nu_deputado_id",             limit: 4
  end

  add_index "despesas", ["deputado_id"], name: "index_despesas_on_deputado_id", using: :btree
  add_index "despesas", ["num_ano", "num_mes"], name: "index_despesas_on_num_ano_and_num_mes", using: :btree

  create_table "versao_web_services", force: :cascade do |t|
    t.string   "url",          limit: 255
    t.string   "sha1hash",     limit: 255
    t.date     "data_arquivo"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "despesas", "deputados"
end
