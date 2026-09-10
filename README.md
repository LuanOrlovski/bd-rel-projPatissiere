# bd-rel-projPatissiere
banco de dados para gestão de uma confeitaria (projeto acad)

A modelagem de dados para o sistema da loja ficticia Pâtisserie Confeitaria Gourmet.
projetada para organizar o inventário, controlar pedidos e registrar dados de forma eficiente. 

# Regra de negocio 
Cardapio modular de bolos, ou seja cada cliente escolhe seu bolo de forma modular (massa, recheio, cobertura etc.)

## Entidades principais:
- Pessoa
- Cliente
- Funcionário
- Atendente
- Confeiteiro
- Pedido
- Pagamento
- Comanda
- Entrega
- Bolo
- Peso / Recheio / Cobertura / Massa / Decoração

## Relacionamentos:
- Pessoa pode ser Cliente ou Funcionário
- Funcionário pode ser Atendente ou Confeiteiro
- Cliente faz Pedido
- Pedido tem Bolo
- Pedido é registrado por Atendente
- Pedido está associado à Comanda
- Pagamento está associado à Comanda
- Confeiteiro recebe uma Comanda
- Entrega se relaciona com Pedido e Cliente
- Bolo é feito por Confeiteiro
- Bolo contém Peso, Recheio, Cobertura, Massa e Decoração

## Alternativa Considerada:
A principal alternativa foi colocar todos os detalhes do bolo (massa, recheio, etc.) em uma única tabela Pedidos. No entanto, essa opção foi descartada porque causaria grande repetição de dados e dificultaria a gestão do cardápio e a análise de vendas. A abordagem modular foi a melhor escolha técnica para o projeto.

Foi decidido por criar cada atributo que compõem um bolo como entidades separadas, motivada pelo fato de se tratar de um pedido modular, significa que cada pedido pode ter o peso, massa, recheio etc., alterado pelo cliente, facilitando a compreensão e modularidade do banco.

##tecnologias (MySQL Workbench, LucidChart (modelagem))
