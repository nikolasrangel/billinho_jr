class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.decimal :valor_fatura, null: false
      t.date :data_vencimento, null: false
      t.string :status, null: false, default: "Aberta"
      t.belongs_to :enrollment, index: true

      t.timestamps
    end
  end
end
