class Aluno < ApplicationRecord
    validates :id_aluno, presence: true
    validates :cpf_responsavel, presence: true
    validates :nome_do_aluno, presence: true
    validates :data_de_nascimento, presence: true

    belongs_to :usuarios, class_name: "usuario", :foreign_key => :cpf, primary_key: 'cpf'
end
