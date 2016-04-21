class DeputadosIndex < Chewy::Index

  define_type Deputado.includes(:despesas) do
    field :nome
    field :partido
    field :nome_parlamentar
    field :matricula
    field :email
    field :uf
    field :despesas do
      field :beneficiario
      field :cpf_cnpj
    end
  end

end
