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

ActiveRecord::Schema.define(version: 20180923220313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.decimal "valor_fatura", null: false
    t.date "data_vencimento", null: false
    t.string "status", default: "Aberta", null: false
    t.bigint "enrollment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_bills_on_enrollment_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.decimal "valor_total", null: false
    t.integer "qtd_faturas", null: false
    t.integer "dia_vencimento", null: false
    t.string "nome_curso", null: false
    t.bigint "institution_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_enrollments_on_institution_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "nome", null: false
    t.string "cnpj", null: false
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_institutions_on_cnpj", unique: true
    t.index ["nome"], name: "index_institutions_on_nome", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "nome_estudante", null: false
    t.string "cpf", null: false
    t.date "data_nascimento"
    t.bigint "telefone_celular"
    t.string "genero", null: false
    t.string "tipo_pagamento", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_students_on_cpf", unique: true
    t.index ["nome_estudante"], name: "index_students_on_nome_estudante", unique: true
  end

end
