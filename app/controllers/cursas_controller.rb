class CursasController < ApplicationController
    def index
        begin
            render json: Cursa.all
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            cursa = Cursa.new(cursa_params)
            if cursa && cursa.id_aluno && cursa.id_disciplina
                save_result = cursa.save

                if save_result
                    render json:cursa
                else
                    render json: {error: cursa.errors.full_messages[0]}, status: 400
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
            cursa = Cursa.find_by_id_cursa(params[:id])
            cursa_r = cursa_params
            if cursa && cursa_r
                if cursa_r[:cpf_professor] == nil || cursa_r[:cpf_professor] && Usuario.find_by_cpf(cursa_r[:cpf_professor])
                    cursa_r.keys.each do |key|
                        cursa[key] = cursa_r[key]
                    end
                    
                    update_result = cursa.update(cursa_r)
                    
                    if update_result
                        render json:cursa
                    else
                        render json: {error: cursa.errors.full_messages[0]}, status: 400
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
            cursa_r = cursa_params
            if cursa_r && cursa_r.id_aluno && cursa_r.id_disciplina
                vinculo = Cursa.where(:id_aluno => cursa_r.id_aluno, :id_disciplina => cursa_r.id_disciplina)
                if vinculo
                    destroy_result = vinculo.destroy
                
                    if destroy_result
                        render json:vinculo
                    else
                        render json: {error: vinculo.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Vínculo de aluno e discipliona não encontrado"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Dados inválidos"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def cursas_disciplina
        begin
            if params[:id_disciplina]
                render json: Cursa.find_by_id_disciplina(params[:id_disciplina])
            else
                render json: {error: "Id de disciplina não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def cursas_aluno
        begin
            if params[:id_aluno]
                render json: Cursa.find_by_id_aluno(params[:id_aluno])
            else
                render json: {error: "Id de aluno não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    private

    def cursa_params
        params.require(:cursa).permit(:id_aluno, :id_disciplina, :nota1, :nota2, :nota3)
    end
end
