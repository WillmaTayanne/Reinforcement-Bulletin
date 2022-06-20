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
            if pagamento && pagamento.id_aluno && pagamento.data_vencimento && pagamento.valor_mensalidade
                update_result = pagamento.update(pagamento_params)
                
                if update_result
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
            render json:Pagamento.where(:id_aluno => params[:id_aluno])
        rescue => e
            render json: {error: e.message}, status: 400
        end
    end

    private

    def pagamento_params
        params.require(:pagamento).permit(:id_aluno, :data_vencimento, :data_pagamento, :valor_mensalidade, :via_de_pagamento)
    end
end
