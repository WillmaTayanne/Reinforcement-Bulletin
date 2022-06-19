class CreatePagamentos < ActiveRecord::Migration[7.0]
  def change
    create_table :pagamentos do |t|
      t.integer :id_aluno, :null => false
      t.date :data_vencimento, :null => false
      t.date :data_pagamento, :null => true
      t.float :valor_mensalidade, :null => false
      t.string :via_de_pagamento, :null => true, :limit => 80
    end

    rename_column :pagamentos, :id, :id_pagamento
    add_index :pagamentos, :id_pagamento, :unique => true
    execute "ALTER TABLE pagamentos ADD CONSTRAINT fk_pagamentos_alunos FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)"
  end
end
