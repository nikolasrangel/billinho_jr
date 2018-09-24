class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :nome_estudante, null: false
      t.string :cpf, null: false
      t.date :data_nascimento
      t.bigint :telefone_celular
      t.string :genero, null: false
      t.string :tipo_pagamento, null: false

      t.timestamps
    end
    add_index :students, :nome_estudante, unique: true
    add_index :students, :cpf, unique: true
  end
end
