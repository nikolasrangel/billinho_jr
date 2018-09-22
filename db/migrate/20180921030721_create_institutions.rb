class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :nome, null: false, index: { unique: true }
      t.string :cnpj, null: false, index: { unique: true }
      t.string :tipo

      t.timestamps
    end
  end
end
