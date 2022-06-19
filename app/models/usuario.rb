class Usuario < ApplicationRecord
    validates :cpf, presence: true
    validates :nome, presence: true
    validates :senha, presence: true
    validates :email, presence: true
    validates :telefone, presence: true
    validates :is_professor, presence: true
end
