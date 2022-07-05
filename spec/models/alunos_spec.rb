require 'rails_helper'

describe Aluno do
  it "Validando Criacao - Aluno" do 
    aluno = Aluno.new(cpf_responsavel: '10145678910', 
      nome_do_aluno: 'Gabriel Henrique',
      data_de_nascimento: '10/02/2022',
      ativo: true)
    aluno.save

    expect(aluno) == Aluno.where(nome_do_aluno: 'Gabriel Henrique',
      cpf_responsavel: '10145678910').first
  end 
end

describe Aluno do
  it "Validando Update - Aluno" do 
    aluno = Aluno.find_by_id_aluno(1)
    oldName = aluno.nome_do_aluno
    aluno.update(nome_do_aluno: 'Gabriel Carlos')
    
    expect(oldName) != Aluno.find_by_id_aluno(1).nome_do_aluno
  end 
end

describe Aluno do
  it "Validando Delete - Aluno" do
    aluno = Aluno.new(cpf_responsavel: '10145678910', 
      nome_do_aluno: 'Gabriel Henrique',
      data_de_nascimento: '10/02/2022',
      ativo: true)
    aluno.save
    result = aluno.destroy    
    
    expect(result) == true
  end 
end

describe Aluno do
  it "Validando Leitura - Aluno" do 
    aluno = Aluno.find_by_id_aluno(1)

    expect(aluno) != nil 
  end 
end
