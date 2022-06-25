class AlunosController < ApplicationController
    def index
        begin
            render json: Aluno.all
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            aluno = Aluno.new(aluno_params)
            if aluno && aluno.cpf_responsavel && aluno.nome_do_aluno && aluno.data_de_nascimento
                aluno.ativo = true
                usuario = Usuario.find_by_cpf(aluno.cpf_responsavel)
                if usuario
                    unless usuario.is_professor
                        save_result = aluno.save

                        if save_result
                            render json:aluno
                        else
                            render json: {error: aluno.errors.full_messages[0]}, status: 400
                        end
                    else
                        render json: {error: "Aluno não pode ter um professor como responsável"}, status: :unprocessable_entity
                    end
                else
                    render json: {error: "Usuário inválido"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Dados inválidos"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end
    
    def update
        begin
            aluno = Aluno.find_by_id_aluno(params[:id])
            aluno_r = aluno_params
            if aluno && aluno_r
                if aluno_r[:cpf_responsavel] == nil || aluno_r[:cpf_responsavel] && Usuario.find_by_cpf(aluno_r[:cpf_responsavel])
                    aluno_r.keys.each do |key|
                        aluno[key] = aluno_r[key]
                    end

                    update_result = aluno.save
                    
                    if update_result
                        render json:aluno
                    else
                        render json: {error: aluno.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Novo CPF de responsável não esta cadastrado"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Dados inválidos"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def destroy
        begin
            aluno = Aluno.find_by_id_aluno(params[:id])
            if aluno
                if aluno.pagamentos.length == 0 && aluno.cursas.length == 0
                    destroy_result = aluno.destroy
                
                    if destroy_result
                        render json:aluno
                    else
                        render json: {error: aluno.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Aluno não pode ser removido pois o mesmo já possui registros vinculados, caso deseje que o mesmo não seja mais acessado desative-o"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Aluno não encontrado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def alunos_responsavel
        begin
            if params[:cpf]
                render json:Aluno.where(:cpf_responsavel => params[:cpf])
            else
                render json: {error: "CPF de responsável não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message}, status: 400
        end
    end

    private

    def aluno_params
        params.require(:aluno).permit(:cpf_responsavel, :nome_do_aluno, :data_de_nascimento, :ativo)
    end
end
