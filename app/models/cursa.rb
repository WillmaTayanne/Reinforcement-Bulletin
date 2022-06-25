class Cursa < ApplicationRecord
    validates :id_disciplina, presence: true
    validates :id_aluno, presence: true

    belongs_to :disciplinas, class_name: "Disciplina", :foreign_key => :id_disciplina, primary_key: 'id_disciplina'
    belongs_to :alunos, class_name: "Aluno", :foreign_key => :id_aluno, primary_key: 'id_aluno'
end
