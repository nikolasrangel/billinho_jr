class Institution < ApplicationRecord
  has_many :enrollments
  validates_uniqueness_of :nome, :cnpj
  validates_presence_of :nome, :cnpj
  validates :cnpj, numericality: { only_integer: true }
  validates :tipo, inclusion: { in: %w(Universidade Escola Creche) }

  before_create :validation

  private
    def validation

    end

end
