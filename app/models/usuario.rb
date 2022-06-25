class Usuario < ApplicationRecord
    validates :cpf, presence: true
    validates :nome, presence: true
    validates :senha, presence: true
    validates :email, presence: true
    validates :telefone, presence: true
    validates :ativo, presence: true

    has_many :alunos, class_name: "Aluno", :foreign_key => :cpf_responsavel, primary_key: 'cpf'
    has_many :disciplinas, class_name: "Disciplina", :foreign_key => :cpf_professor, primary_key: 'cpf'
end
