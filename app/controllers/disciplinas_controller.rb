class DisciplinasController < ApplicationController
    def index
        begin
            render json: Disciplina.all
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            disciplina = Disciplina.new(disciplina_params)
            if disciplina && disciplina.cpf_professor && disciplina.nome_disciplina

                usuario = Usuario.find_by_cpf(disciplina.cpf_professor)
                if usuario
                    if usuario.is_professor
                        save_result = disciplina.save

                        if save_result
                            render json:disciplina
                        else
                            render json: {error: disciplina.errors.full_messages[0]}, status: 400
                        end
                    else
                        render json: {error: "Disciplina não pode ser ministrada por um responsável"}, status: :unprocessable_entity
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
            disciplina = Disciplina.find_by_id_disciplina(params[:id])
            disciplina_r = disciplina_params
            if disciplina && disciplina_r
                if disciplina_r[:cpf_professor] == nil || disciplina_r[:cpf_professor] && Usuario.find_by_cpf(disciplina_r[:cpf_professor])
                    disciplina_r.keys.each do |key|
                        disciplina[key] = disciplina_r[key]
                    end

                    update_result = disciplina.save
                    
                    if update_result
                        render json:disciplina
                    else
                        render json: {error: disciplina.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Novo CPF do professor não esta cadastrado"}, status: :unprocessable_entity
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
            disciplina = Disciplina.find_by_id_disciplina(params[:id])
            if disciplina
                if disciplina.cursas.length == 0
                    destroy_result = disciplina.destroy
                
                    if destroy_result
                        render json:disciplina
                    else
                        render json: {error: disciplina.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Disciplina não pode ser removido pois o mesmo já alunos cadastrados na mesma, caso deseje remover tal disciplina primeiro remova os alunos da disciplina"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Disciplina não encontrado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def disciplinas_professor
        begin
            if params[:cpf]
                render json:Disciplina.where(:cpf_professor => params[:cpf])
            else
                render json: {error: "CPF de professor não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message}, status: 400
        end
    end

    private

    def disciplina_params
        params.require(:disciplina).permit(:cpf_professor, :nome_disciplina, :ativo)
    end
end
