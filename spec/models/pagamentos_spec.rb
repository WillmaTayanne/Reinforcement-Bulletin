require 'rails_helper'

describe Pagamento do
  it "Validando Criacao - Pagamento" do 
    user = Pagamento.new(id_aluno: 2,
        data_vencimento: '2022-08-10',
        data_pagamento: nil,
        valor_mensalidade: 80.0,
        via_de_pagamento: nil,
        )
    user.save

    expect(user) == Pagamento.where(id_aluno: 2, data_vencimento: '2022-08-10').first
  end 
end

describe Pagamento do
  it "Validando Update - Pagamento" do 
    user = Pagamento.find_by_id_pagamento(3)
    oldDate = user.data_pagamento
    user.update(data_pagamento: DateTime.current.to_date)
    
    expect(oldDate) != Pagamento.find_by_id_pagamento(3).data_pagamento
  end 
end

describe Pagamento do
  it "Validando Delete - Pagamento" do
    user = Pagamento.new(id_aluno: 2,
        data_vencimento: '2022-08-10',
        data_pagamento: nil,
        valor_mensalidade: 80.0,
        via_de_pagamento: nil,
    )
    user.save
    result = user.destroy    
    
    expect(result) == true
  end 
end

describe Pagamento do
  it "Validando Leitura - Pagamento" do 
    user = Pagamento.find_by_id_pagamento(3)

    expect(user) != nil 
  end 
end
