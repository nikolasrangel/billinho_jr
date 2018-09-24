class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student
  has_many :bills

  validates_presence_of :valor_total, :qtd_faturas, :dia_vencimento, :nome_curso
  validates :valor_total, numericality: { greater_than: 0 }
  validates :qtd_faturas, numericality: { greater_than_or_equal_to: 1 }
  validates :dia_vencimento, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }

  after_create :insert_bills

  private
  def insert_bills
    # Calculates the value of each bill
    @bills_value = (self.valor_total/self.qtd_faturas).round(4)

    # Current date
    @day = Date.today.day
    @month = Date.today.month
    @year = Date.today.year

    if (self.dia_vencimento <= @day)
      # It will be in the next month
      @next_bill = Date.new(@year, @month, self.dia_vencimento) >> 1
    else
      # It will be in the current month
      @next_bill = Date.new(@year, @month, self.dia_vencimento)
    end

    # Insert each bill into database
    self.qtd_faturas.times do
      @bill = Bill.create(valor_fatura: @bills_value, data_vencimento: @next_bill, enrollment_id: self.id)
      # Calculates the next bill's date
      @next_bill = @next_bill >> 1
    end

  end

end
