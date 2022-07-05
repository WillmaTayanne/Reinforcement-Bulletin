require 'rails_helper'

describe Usuario do
  it "Validando Criação - Usuario" do 
    user = Usuario.new(cpf: '12345678908', 
      nome: 'Teste Responsavel', 
      senha: '1234567890',
      email: 'teste@teste.com',
      telefone: '12345678901',
      is_professor: true,
      ativo: true)
    user.save

    expect(user) == Usuario.find_by_cpf("12345678908")
  end 
end

describe Usuario do
  it "Validando Update - Usuario" do 
    user = Usuario.find_by_cpf('12345678917')
    oldName = user.nome
    user.update(nome: 'Teste Responsavel')
    
    expect(oldName) != user.nome
  end 
end

describe Usuario do
  it "Validando Delete - Usuario" do
    user = Usuario.new(cpf: '12345678908', 
      nome: 'Teste Responsavel', 
      senha: '1234567890',
      email: 'teste@teste.com',
      telefone: '12345678901',
      is_professor: true,
      ativo: true)
    user.save
    result = user.destroy    
    
    expect(result) == true
  end 
end

describe Usuario do
  it "Validando Leitura - Usuario" do 
    user = Usuario.find_by_cpf("12345678908")

    expect(user) != nil 
  end 
end
