class CreateCursas < ActiveRecord::Migration[7.0]
  def change
    create_table :cursas do |t|
      t.integer :id_disciplina, :null => true
      t.integer :id_aluno, :null => true
      t.float :nota1, :null => true
      t.float :nota2, :null => true
      t.float :nota3, :null => true
      t.integer :status, :null => false, :default => 0
    end

    rename_column :cursas, :id, :id_cursa
    execute "ALTER TABLE cursas ADD CONSTRAINT fk_cursas_alunos FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)"
    execute "ALTER TABLE cursas ADD CONSTRAINT fk_cursas_disciplinas FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)"
  end
end
