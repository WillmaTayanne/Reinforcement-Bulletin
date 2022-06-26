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
                aluno = Aluno.find_by_id_aluno(cursa.id_aluno)
                disciplina = Disciplina.find_by_id_disciplina(cursa.id_disciplina)
                if aluno && disciplina
                    save_result = cursa.save

                    if save_result
                        render json:cursa
                    else
                        render json: {error: cursa.errors.full_messages[0]}, status: 400
                    end   
                elsif disciplina
                    render json: {error: "Aluno não encontrado"}, status: :unprocessable_entity
                else
                    render json: {error: "Disciplina não encontrada"}, status: :unprocessable_entity
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
                if cursa_r[:id_disciplina] && Disciplina.find_by_id_disciplina(cursa_r[:id_disciplina]) == nil
                    render json: {error: "Disciplina não encontrada"}, status: :unprocessable_entity
                elsif cursa_r[:id_aluno] && Aluno.find_by_id_aluno(cursa_r[:id_aluno]) == nil
                    render json: {error: "Aluno não encontrado"}, status: :unprocessable_entity
                else
                    cursa_r.keys.each do |key|
                        cursa[key] = cursa_r[key]
                    end
                    
                    update_result = cursa.save
                    
                    if update_result
                        render json:cursa
                    else
                        render json: {error: cursa.errors.full_messages[0]}, status: 400
                    end
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
            cursa = Cursa.find_by_id_cursa(params[:id])
            if cursa
                cursa_result = cursa.destroy

                if cursa_result
                    render json:cursa
                else
                    render json: {error: cursa.errors.full_messages[0]}, status: 400
                end
            else
                render json: {error: "Vínculo de aluno e discipliona não encontrado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def cursas_disciplina
        begin
            if params[:id_disciplina]
                disciplina = Disciplina.find_by_id_disciplina(params[:id_disciplina])
                if disciplina
                    render json: disciplina.cursas
                else
                    render json: {error: "Disciplina não encontrada"}, status: :unprocessable_entity
                end
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
                aluno = Aluno.find_by_id_aluno(params[:id_aluno])
                if aluno
                    render json: aluno.cursas
                else
                    render json: {error: "Aluno não encontrado"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Id de aluno não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    private

    def cursa_params
        params.require(:cursa).permit(:id_aluno, :id_disciplina, :nota1, :nota2, :nota3, :status)
    end
end
