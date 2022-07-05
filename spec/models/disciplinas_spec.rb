require 'rails_helper'

describe Disciplina do
  it "Validando Criacao - disciplina" do 
    disciplina = Disciplina.new(cpf_professor: "10545678922",
        nome_disciplina: 'Historia',
      ativo: true)
    disciplina.save

    expect(disciplina) == Disciplina.where(cpf_professor: '10545678922', nome_disciplina: 'Historia').first
  end 
end

describe Disciplina do
  it "Validando Update - disciplina" do 
    disciplina = Disciplina.find_by_id_disciplina(1)
    oldName = disciplina.nome_disciplina
    disciplina.update(nome_disciplina: 'Matématica')
    
    expect(oldName) != Disciplina.find_by_id_disciplina(1).nome_disciplina
  end 
end

describe Disciplina do
  it "Validando Delete - disciplina" do
    disciplina = Disciplina.new(cpf_professor: "10545678922",
        nome_disciplina: 'Historia',
        ativo: true)
    disciplina.save
    result = disciplina.destroy    
    
    expect(result) == true
  end 
end

describe Disciplina do
  it "Validando Leitura - disciplina" do 
    disciplina = Disciplina.find_by_id_disciplina(1)

    expect(disciplina) != nil 
  end 
end
