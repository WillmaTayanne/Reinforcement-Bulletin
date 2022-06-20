class UsuariosController < ApplicationController
    def index
        begin
            render json: Usuario.all.select(:cpf, :nome, :email, :telefone, :is_professor)
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def create
        begin
            usuario = Usuario.new(usuario_params)
            if usuario && usuario.cpf && usuario.nome && usuario.senha && usuario.email && usuario.telefone
                if Usuario.find_by_cpf(usuario.cpf)
                    render json: {error: "CPF já cadastrado"}, status: :unprocessable_entity
                elsif Usuario.find_by_email(usuario.email)
                    render json: {error: "Email já cadastrado"}, status: :unprocessable_entity
                else
                    save_result = usuario.save
                    if save_result
                        render json: format_render(usuario)
                    else
                        render json: {error: usuario.errors.full_messages[0]}, status: 400
                    end
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
            usuario_r = usuario_params
            if usuario && usuario_r.cpf && usuario_r.nome && usuario_r.email && usuario_r.telefone && usuario_r.is_professor
                if Usuario.find_by_cpf(usuario_r.cpf)
                    render json: {error: "CPF já cadastrado"}, status: :unprocessable_entity
                elsif Usuario.find_by_email(usuario_r.email)
                    render json: {error: "Email já cadastrado"}, status: :unprocessable_entity
                else
                    unless usuario_r.senha
                        usuario_r.senha = usuario.senha
                    end

                    update_result = usuario.update(usuario_params)

                    if update_result
                        render json: format_render(usuario)
                    else
                        render json: {error: usuario.errors.full_messages[0]}, status: 400
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
            usuario = Usuario.find_by_cpf(params[:id])
            if usuario
                destroy_result = usuario.destroy

                if destroy_result
                    render json: format_render(usuario)
                else
                    render json: {error: usuario.errors.full_messages[0]}, status: 400
                end
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
                if usuario
                    render json: format_render(usuario)
                else
                    render json: {error: "Usuário ou senha inválidos"}, status: :unprocessable_entity
                end
            else
                render json: {error: "Dados inválidos"}, status: :unprocessable_entity
            end
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    private

    def format_render(usuario)
        {cpf: usuario.cpf, nome: usuario.nome, email: usuario.email, telefone: usuario.telefone, is_professor: usuario.is_professor}
    end

    def usuario_params
        params.require(:usuario).permit(:cpf, :nome, :senha, :email, :telefone, :is_professor)
    end
end
