require 'rails_helper'

describe Cursa do
  it "Validando Criacao - Cursa" do 
    cursa = Cursa.new(id_disciplina: 1,
        id_aluno: 3,
        nota1: 8,
        nota2: nil,
        nota3: nil,
        status: 0)
    cursa.save

    expect(cursa) == Cursa.where(id_disciplina: 1, id_aluno: 3).first
  end 
end

describe Cursa do
  it "Validando Update - Cursa" do 
    cursa = Cursa.where(id_disciplina: 1, id_aluno: 1).first
    oldNota1 = cursa.nota1
    cursa.update(nota1: 9)
    
    expect(oldNota1) != Cursa.where(id_disciplina: 1, id_aluno: 1).first
  end 
end

describe Cursa do
  it "Validando Delete - Cursa" do
    cursa = Cursa.new(id_disciplina: 1,
        id_aluno: 3,
        nota1: 8,
        nota2: nil,
        nota3: nil,
        status:0)
    cursa.save
    result = cursa.destroy    
    
    expect(result) == true
  end 
end

describe Cursa do
  it "Validando Leitura - Cursa" do 
    cursa = Cursa.where(id_disciplina: 1, id_aluno: 1).first

    expect(cursa) != nil 
  end 
end
