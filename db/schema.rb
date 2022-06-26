# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_19_013755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", primary_key: "id_aluno", id: :bigint, default: -> { "nextval('alunos_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "cpf_responsavel", limit: 11, null: false
    t.string "nome_do_aluno", null: false
    t.date "data_de_nascimento", null: false
    t.boolean "ativo", default: true, null: false
    t.index ["id_aluno"], name: "index_alunos_on_id_aluno", unique: true
  end

  create_table "cursas", primary_key: "id_cursa", id: :bigint, default: -> { "nextval('cursas_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "id_disciplina"
    t.integer "id_aluno"
    t.float "nota1"
    t.float "nota2"
    t.float "nota3"
    t.integer "status", default: 0, null: false
  end

  create_table "disciplinas", primary_key: "id_disciplina", id: :bigint, default: -> { "nextval('disciplinas_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "cpf_professor", limit: 11, null: false
    t.string "nome_disciplina", limit: 80, null: false
    t.boolean "ativo", default: true, null: false
    t.index ["id_disciplina"], name: "index_disciplinas_on_id_disciplina", unique: true
  end

  create_table "pagamentos", primary_key: "id_pagamento", id: :bigint, default: -> { "nextval('pagamentos_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "id_aluno", null: false
    t.date "data_vencimento", null: false
    t.date "data_pagamento"
    t.float "valor_mensalidade", null: false
    t.string "via_de_pagamento", limit: 80
    t.index ["id_pagamento"], name: "index_pagamentos_on_id_pagamento", unique: true
  end

  create_table "usuarios", primary_key: "cpf", id: { type: :string, limit: 11 }, force: :cascade do |t|
    t.string "nome", null: false
    t.string "senha", limit: 80, null: false
    t.string "email", null: false
    t.string "telefone", limit: 11, null: false
    t.boolean "is_professor", default: false, null: false
    t.boolean "ativo", default: true, null: false
    t.index ["cpf"], name: "index_usuarios_on_cpf", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "alunos", "usuarios", column: "cpf_responsavel", primary_key: "cpf", name: "fk_alunos_usuarios", on_update: :cascade
  add_foreign_key "cursas", "alunos", column: "id_aluno", primary_key: "id_aluno", name: "fk_cursas_alunos"
  add_foreign_key "cursas", "disciplinas", column: "id_disciplina", primary_key: "id_disciplina", name: "fk_cursas_disciplinas"
  add_foreign_key "disciplinas", "usuarios", column: "cpf_professor", primary_key: "cpf", name: "fk_disciplinas_usuarios", on_update: :cascade
  add_foreign_key "pagamentos", "alunos", column: "id_aluno", primary_key: "id_aluno", name: "fk_pagamentos_alunos"
end
