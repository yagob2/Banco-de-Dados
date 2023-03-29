create table cliente(
id integer primary key autoincrement not null,
nome_completo text,
nome_usuario text 
email text,
cpf integer,
data_nascimento text,
endereco text
)

create table pedido (
id integer primary key autoincrement not null,
data_pedido  text,
id_funcionario integer,
foreign key(id_funcionario) references funcionario(id)
)

create table funcionario(
id integer primary key autoincrement not null,
nome text,
cpf integer
)

create table produto(
id integer primary key autoincrement not null,
nome text,
descricao text,
quantidade_no_estoque integer,
data_de_fabricacao text,
valor_unitario integer,
id_categoria integer,
foreign key(id_categoria) references categoria(id)
)

create table categoria (
id integer primary key autoincrement not null,
nome text,
descricao text
)

create table produto_pedido(
id integer primary key autoincrement not null,
id_produto integer,
id_pedido integer,
foreign key(id_produto) references produto(id),
foreign key(id_pedido) references pedido(id)
)
