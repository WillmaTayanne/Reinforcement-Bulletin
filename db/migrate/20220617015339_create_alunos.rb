class CreateAlunos < ActiveRecord::Migration[7.0]
  def change
    create_table :alunos do |t|
      t.string :cpf_responsavel, :limit => 11, :null =>  false
      t.string :nome_do_aluno, :null =>  false
      t.date :data_de_nascimento, :null =>  false
      t.boolean :ativo, :null => false, :default => true
    end

    rename_column :alunos, :id, :id_aluno
    add_index :alunos, :id_aluno, :unique => true
    execute "ALTER TABLE alunos ADD CONSTRAINT fk_alunos_usuarios FOREIGN KEY (cpf_responsavel) REFERENCES usuarios(cpf) ON UPDATE CASCADE"
  end
end
