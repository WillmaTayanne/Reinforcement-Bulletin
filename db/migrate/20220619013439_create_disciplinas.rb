class CreateDisciplinas < ActiveRecord::Migration[7.0]
  def change
    create_table :disciplinas do |t|
      t.string :cpf_professor, :limit => 11, :null => false
      t.string :nome_disciplina, :null => false, :limit => 80
      t.boolean :ativo, :null => false, :default => true
    
    end

    rename_column :disciplinas, :id, :id_disciplina
    add_index :disciplinas, :id_disciplina, :unique => true
    execute "ALTER TABLE disciplinas ADD CONSTRAINT fk_disciplinas_usuarios FOREIGN KEY (cpf_professor) REFERENCES usuarios(cpf) ON UPDATE CASCADE"
  end
end
