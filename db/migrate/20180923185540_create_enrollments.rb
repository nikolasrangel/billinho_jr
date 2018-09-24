class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.decimal :valor_total, null: false
      t.integer :qtd_faturas, null: false
      t.integer :dia_vencimento, null: false
      t.string :nome_curso, null: false
      t.belongs_to :institution, index: true
      t.belongs_to :student, index: true
    
      t.timestamps
    end
  end
end
