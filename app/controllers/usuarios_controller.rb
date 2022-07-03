class UsuariosController < ApplicationController
    def index
        begin
            render json: Usuario.select(:cpf, :nome, :email, :telefone, :is_professor, :ativo)
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
            if usuario && usuario_params
                if usuario_r[:cpf] && usuario.cpf != usuario_r[:cpf] && Usuario.find_by_cpf(usuario_r[:cpf])
                    render json: {error: "CPF já cadastrado"}, status: :unprocessable_entity
                elsif usuario_r[:email] && usuario.email != usuario_r[:email] && Usuario.find_by_email(usuario_r[:email])
                    render json: {error: "Email já cadastrado"}, status: :unprocessable_entity
                elsif usuario_r[:is_professor] != nil && usuario.is_professor != usuario_r[:is_professor] &&
                    (usuario.alunos.length != 0 || usuario.disciplinas.length != 0)
                    render json: {error: "Flag de professor / responsável não pode ser alterada pois tal usuário já possui disciplinas / alunos vinculados ao mesmo"}, status: :unprocessable_entity
                else
                    usuario_r.keys.each do |key|
                        usuario[key] = usuario_r[key]
                    end
                    
                    update_result = usuario.save

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
                if usuario.alunos.length == 0 && usuario.disciplinas.length == 0
                    destroy_result = usuario.destroy

                    if destroy_result
                        render json: format_render(usuario)
                    else
                        render json: {error: usuario.errors.full_messages[0]}, status: 400
                    end
                else
                    render json: {error: "Usuário não pode ser removido pois o mesmo já possui registros vinculados, caso deseje que o mesmo não se logue novamente desative-o"}, status: :unprocessable_entity
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
                    if usuario.ativo
                        result = format_render(usuario)

                        if usuario.is_professor
                            result[:disciplinas] = usuario.disciplinas
                        else
                            result[:alunos] = usuario.alunos
                        end

                        render json: result
                    else
                        render json: {error: "Seu acesso foi desativado"}, status: :unprocessable_entity
                    end
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

    def responsaveis
        begin
            responsaveis = []
            Usuario.where(:is_professor => false).each do |responsavel|
                result = format_render(responsavel)
                result[:alunos] = responsavel.alunos
                responsaveis.push(result)
            end

            render json: responsaveis
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    def professores
        begin
            professores = []
            Usuario.where(:is_professor => true).each do |professor|
                result = format_render(professor)
                result[:disciplinas] = professor.disciplinas
                professores.push(result)
            end

            render json: professores
        rescue => e
            render json: {error: e.message }, status: 400
        end
    end

    private

    def format_render(usuario)
        {cpf: usuario.cpf, nome: usuario.nome, email: usuario.email, telefone: usuario.telefone, is_professor: usuario.is_professor, ativo: usuario.ativo}
    end

    def usuario_params
        params.require(:usuario).permit(:cpf, :nome, :senha, :email, :telefone, :is_professor, :ativo)
    end
end
