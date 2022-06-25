class PagamentosController < ApplicationController
    def index
        begin
            render json: Pagamento.all
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            pagamento = Pagamento.new(pagamento_params)
            if pagamento && pagamento.id_aluno && pagamento.data_vencimento && pagamento.valor_mensalidade
                save_result = pagamento.save
                
                if save_result
                    render json:pagamento
                else
                    render json: {error: pagamento.errors.full_messages[0]}, status: 400
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
            pagamento = Pagamento.find_by_id_pagamento(params[:id])
            pagamento_r = pagamento_params
            if pagamento && pagamento_r
                if pagamento_r[:id_aluno] == nil || pagamento_r[:id_aluno] && Aluno.find_by_id_aluno(pagamento_r[:id_aluno])
                    pagamento_r.keys.each do |key|
                        pagamento[key] = pagamento_r[key]
                    end

                    update_result = pagamento.save
                
                    if update_result
                        render json:pagamento
                    else
                        render json: {error: pagamento.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Novo aluno a ser vinculado não esta cadastrado"}, status: :unprocessable_entity
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
            pagamento = Pagamento.find_by_id_pagamento(params[:id])
            if pagamento
                destroy_result = pagamento.destroy
                
                if destroy_result
                    render json:pagamento
                else
                    render json: {error: pagamento.errors.full_messages[0]}, status: 400
                end
            else
                render json: {error: "Pagamento não encontrado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def pagamentos_aluno
        begin
            if params[:id_aluno]
                render json:Pagamento.where(:id_aluno => params[:id_aluno]).first
            else
                render json: {error: "Id de aluno não foi informado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message}, status: 400
        end
    end

    private

    def pagamento_params
        params.require(:pagamento).permit(:id_aluno, :data_vencimento, :data_pagamento, :valor_mensalidade, :via_de_pagamento)
    end
end
