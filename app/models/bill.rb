class Bill < ApplicationRecord
  belongs_to :enrollment
  
  validates_presence_of :valor_fatura, :data_vencimento, :enrollment_id, :status
  validates :status, inclusion: { in: %w(Aberta Atrasada Paga) }
end
