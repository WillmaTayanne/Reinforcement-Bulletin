Rails.application.routes.draw do
  post 'login', to: 'usuarios#login'
  get 'alunos/responsavel/:cpf', to: 'alunos#alunos_responsavel'
  get 'pagamentos/aluno/:id_aluno', to: 'pagamentos#pagamentos_aluno'
  resources :usuarios, only: [:create, :index, :update, :destroy]
  resources :alunos, only: [:create, :index, :update, :destroy]
  resources :pagamentos, only: [:create, :index, :update, :destroy]
end
