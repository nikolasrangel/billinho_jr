# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |index|
  Institution.create({
    nome: "UNIFESP #{index}",
    cnpj: "#{index}",
    tipo: "idk"
  })
end

10.times do |index|
  Student.create({
    nome: "Nome #{index}",
    cpf: "#{index}",
    data_nascimento: Date.new(1994, 5, 20),
    telefone_celular: 12981805381,
    genero: "M",
    tipo_pagamento: "Cartão"

  })
end
