class Disciplina < ApplicationRecord
    validates :cpf_professor, presence: true
    validates :nome_disciplina, presence: true
    validates :ativo, presence: true

    belongs_to :usuarios, class_name: "Usuario", :foreign_key => :cpf_professor, primary_key: 'cpf'
    has_many :cursas, class_name: "Cursa", :foreign_key => :id_disciplina, primary_key: 'id_disciplina'
end
