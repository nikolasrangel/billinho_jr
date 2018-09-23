class Student < ApplicationRecord
  validates_uniqueness_of :nome, :cpf
  validates_presence_of :nome, :cpf, :genero, :tipo_pagamento
  validates :cpf, numericality: { only_integer: true }
  validate :data_nascimento, :data_nascimento_validation
  validates :telefone_celular, numericality: { only_integer: true }
  validates :genero, inclusion: { in: %w(M F) }
  validates :tipo_pagamento, inclusion: { in: %w(Boleto Cartão) }

  private
    def data_nascimento_validation
      errors.add(:data_nascimento, "Must be in YYYY-MM-DD format.") unless data_nascimento.is_a?(Date)
    end

end
