class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios, :id => false do |t|
      t.string :cpf, :limit => 11, :null => false, :primary_key => true
      t.string :nome, :null =>  false
      t.string :senha, :limit => 80, :null => false
      t.string :email, :null =>  false
      t.string :telefone, :limit => 11, :null =>  false
      t.boolean :is_professor, :null =>  false, :default => false
    end

    add_index :usuarios, :cpf, :unique => true
    add_index :usuarios, :email, :unique => true    
  end
end
