class Aluno < ApplicationRecord
    validates :cpf_responsavel, presence: true
    validates :nome_do_aluno, presence: true
    validates :data_de_nascimento, presence: true

    belongs_to :usuarios, class_name: "Usuario", :foreign_key => :cpf_responsavel, primary_key: 'cpf'
    has_many :pagamentos, class_name: "Pagamento", :foreign_key => :id_aluno, primary_key: 'id_aluno'
end
