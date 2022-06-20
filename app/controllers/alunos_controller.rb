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
                save_result = aluno.save
                
                if save_result
                    render json:aluno
                else
                    render json: {error: aluno.errors.full_messages[0]}, status: 400
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
            if aluno && aluno_r.cpf_responsavel && aluno_r.nome_do_aluno && aluno_r.data_de_nascimento && aluno_r.ativo
                if Usuario.find_by_cpf(aluno_r.cpf_responsavel)
                    update_result = aluno.update(aluno_r)
                    
                    if update_result
                        render json:aluno
                    else
                        render json: {error: aluno.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "CPF do responsável não cadastrado"}, status: :unprocessable_entity
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
                destroy_result = aluno.destroy
                
                if destroy_result
                    render json:aluno
                else
                    render json: {error: aluno.errors.full_messages[0]}, status: 400
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
            render json:Aluno.where(:cpf_responsavel => params[:cpf])
        rescue => e
            render json: {error: e.message}, status: 400
        end
    end

    private

    def aluno_params
        params.require(:aluno).permit(:cpf_responsavel, :nome_do_aluno, :data_de_nascimento, :ativo)
    end
end
