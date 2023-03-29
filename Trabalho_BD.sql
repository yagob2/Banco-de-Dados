--criação das tabelas (DDL)

create table cliente(
	id integer primary key autoincrement not null,
	nome_completo text,
	nome_usuario text,
	cpf integer,
	data_nascimento text,
	endereco text
);

alter table cliente add column email text 

create table funcionario(
	id integer primary key autoincrement not null,
	nome text,
	cpf integer
);

create table pedido (
	id integer primary key autoincrement not null,
	data_pedido text,
	id_funcionario integer,
	id_cliente integer,
	foreign key(id_funcionario) references funcionario(id),
	foreign key(id_cliente) references cliente(id)
);

create table categoria (
	id integer primary key autoincrement not null,
	nome text,
	descricao text
);

create table produto(
	id integer primary key autoincrement not null,
	nome text,
	descricao text,
	quantidade_no_estoque integer,
	data_de_fabricacao text,
	valor_unitario integer,
	id_categoria integer,
	id_funcionario integer,
	foreign key(id_categoria) references categoria(id),
	foreign key(id_funcionario) references funcionario(id)
);

create table produto_pedido(
	id integer primary key autoincrement not null,
	id_produto integer,
	id_pedido integer,
	foreign key(id_produto) references produto(id),
	foreign key(id_pedido) references pedido(id)
);

alter table produto_pedido add column
quantidade integer 



--inserção de dados nas tabelas (pelo menos 5 registros em cada uma) (DML)


insert into cliente (nome_completo, nome_usuario, cpf, data_nascimento, endereco) values
('Nelson', '@nelson', 80215458810,'26/02/1997','Praça Pasteur'),
('Pedro', '@pedro', 99999999,'25/02/1997','Petrópolis'),
('João', '@joao', 7777854777,'24/04/1997','Rio de Janeiro'),
('Mario', '@mario', 6541008810,'21/02/1997','Macae'),
('Carlos', '@carlos', 8021789458810,'21/02/1997','Praça Catulo')


insert into funcionario (nome,cpf) values
('Pedro', 80215458810),
('João',88888888888),
('Marcos',9999999999),
('Francisco',2222222222),
('Carlos',5555555555555);


insert into pedido (data_pedido,id_funcionario,id_cliente) values
('26/02/1997',
(select id from funcionario where nome = 'Pedro' ),
(select id from cliente where nome_completo = 'Nelson' )),
('07/05/2022',
(select id from funcionario where nome = 'João' ),
(select id from cliente where nome_completo = 'Mario' )),
('08/05/2015',
(select id from funcionario where nome = 'Marcos' ),
(select id from cliente where nome_completo = 'João' )),
('06/07/2015',
(select id from funcionario where nome = 'Francisco' ),
(select id from cliente where nome_completo = 'Pedro' )),
('07/05/2015',
(select id from funcionario where nome = 'Marcos' ),
(select id from cliente where nome_completo = 'Pedro' ));

insert into produto (nome,descricao,quantidade_no_estoque,data_de_fabricacao,valor_unitario,id_categoria,id_funcionario) values
('Computador','Um belo computador',205,'14/02/1998',2500,1,2),
('Navio','Um belo navio',3,'20/02/1998',250000,1,3),
('Tesoura','Uma bela tesoura',5,'21/02/1998',2,1,1),
('Pá','Uma bela páo',15,'25/02/1998',250,1,5),
('Carro','Um belo carro',25,'26/02/1998',25000,1,4);

insert into categoria (nome,descricao) values
('Veiculos','Carros e motos'),
('Ferramentas','Para obras'),
('Materias básicos','construção'),
('alimentos','revenda'),
('computadores','estoque');

insert into produto_pedido (id_produto,id_pedido,quantidade) values
((select id from produto where nome = 'Computador' ),9,3),
((select id from produto where nome = 'Navio' ),10,5),
((select id from produto where nome ='Carro'),11,4),
((select id from produto where nome = 'Tesoura'),12,2),
((select id from produto where nome ='Pá'),13,1)

insert into produto_pedido (id_produto,id_pedido,quantidade) values
((select id from produto where nome = 'Computador' ),10,3)


--atualização em algum registro em uma tabela (DML)

update cliente 
set email = 'nelson@outllool.com' 
where id = 1;

update cliente 
set email = 'pedro@outllool.com'
where id = 3;

update cliente 
set email = 'joao@outllool.com'
where id = 4;

update cliente 
set email = 'mario@outllool.com'
where id = 5;

update cliente 
set email = 'carlos@outllool.com'
where id = 6;

--exclusão de algum registro em uma tabela (DML)

delete from cliente 
where id = 2




-- SQL querry Pelo menos 2 com algum tipo de junção

SELECT p.data_pedido,
		c.nome_completo
		FROM cliente c INNER JOIN 
		pedido p ON 
		p.id_cliente = c.id


SELECT c.nome as nome_categoria,
		p.nome as nome_produto
		FROM categoria c INNER JOIN 
		produto p ON 
		p.id_categoria = c.id



-- SQL Query Pelo menos 1 com usando count() e group by()

select id, count(*)
from cliente 
where id in (select id
					from cliente 
					where nome_completo like '%A%')
group by id


--Uma consulta livre

select nome_completo 
from cliente 
where nome_completo like 'N%' 


-- Nota fiscal 

select c.nome_completo,
c.cpf,
pedido.data_pedido as Data_pedido,
produto_pedido.quantidade, 
(produto_pedido.quantidade * produto.valor_unitario) as valor_nota 
from cliente c
inner join pedido on pedido.id_cliente = c.id
inner join produto_pedido on produto_pedido.id_pedido = pedido.id
inner join produto on produto.id = produto_pedido.id_produto 
-- Selecionando nota fiscal de um cliente 
--where c.nome_completo = 'Mario'
--and pedido.data_pedido = '07/05/2022'




