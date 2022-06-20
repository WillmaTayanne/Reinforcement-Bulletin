class Pagamento < ApplicationRecord
    validates :id_aluno, presence: true
    validates :data_vencimento, presence: true
    validates :valor_mensalidade, presence: true

    belongs_to :alunos, class_name: "Aluno", :foreign_key => :id_aluno, primary_key: 'id_aluno'
end
