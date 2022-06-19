class UsuariosController < ApplicationController
    def index
        begin
            render json: Usuario.all
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            usuario = Usuario.new(usuario_params)
            if usuario && usuario.cpf && usuario.nome && usuario.senha && usuario.email && usuario.telefone && usuario.is_professor
                if Usuario.find_by_cpf(usuario.cpf)
                    render json: {error: "CPF já cadastrado"}, status: :unprocessable_entity
                elsif Usuario.find_by_email(usuario.email)
                    render json: {error: "Email já cadastrado"}, status: :unprocessable_entity
                else
                    usuario.save
                    render json:usuario
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
            usuario = Usuario.find_by_cpf(params[:id])
            if usuario
                if Usuario.find_by_cpf(usuario.cpf)
                    render json: {error: "CPF já cadastrado"}, status: :unprocessable_entity
                elsif Usuario.find_by_email(usuario.email)
                    render json: {error: "Email já cadastrado"}, status: :unprocessable_entity
                else
                    usuario.update(usuario_params)
                    render json:usuario
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
            usuario = Usuario.find_by_cpf(params[:id])
            if usuario
                usuario.destroy
                render json:usuario
            else
                render json: {error: "Usuário não encontrado"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def login
        begin
            if params[:cpf] && params[:senha]
                usuario = Usuario.where(cpf: params[:cpf], senha: params[:senha]).first
                render json:usuario
            else
                render json: {error: "Dados inválidos"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    private

    def usuario_params
        params.require(:usuario).permit(:cpf, :nome, :senha, :email, :telefone, :is_professor)
    end
end
