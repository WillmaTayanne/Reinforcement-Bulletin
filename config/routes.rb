Rails.application.routes.draw do
  post 'login', to: 'usuarios#login'
  get 'professores', to: 'usuarios#professores'
  get 'responsaveis', to: 'usuarios#responsaveis'
  get 'alunos/responsavel/:cpf', to: 'alunos#alunos_responsavel'
  get 'alunos/responsavel/:cpf', to: 'alunos#alunos_responsavel'
  get 'disciplinas/professor/:cpf', to: 'disciplinas#disciplinas_professor'
  get 'pagamentos/aluno/:id_aluno', to: 'pagamentos#pagamentos_aluno'
  get 'cursas/disciplina/:id_disciplina', to: 'cursas#cursas_disciplina'
  get 'cursas/aluno/:id_aluno', to: 'cursas#cursas_aluno'
  resources :usuarios, only: [:create, :index, :update, :destroy]
  resources :alunos, only: [:create, :index, :update, :destroy]
  resources :pagamentos, only: [:create, :index, :update, :destroy]
  resources :disciplinas, only: [:create, :index, :update, :destroy]
  resources :cursas, only: [:create, :index, :update, :destroy]
end
