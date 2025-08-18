drop table if exists emprestimo_por_livro cascade;
drop table if exists livro_por_autor cascade;
drop table if exists emprestimo cascade;
drop table if exists cliente cascade;
drop table if exists autor cascade;
drop table if exists livro cascade;



create table if not exists autor (
	id integer primary key not null,
	nome varchar(100) not null,
	nacionalidade varchar(100) not null
);

create table if not exists livro (
	id integer primary key not null,
	titulo varchar(100) not null,
	anoPublicacao integer not null,
	isbn integer not null
);

create table if not exists livro_por_autor (
	idlivro integer not null,
	idautor integer not null,
	foreign key(idlivro) references livro(id),
	foreign key(idautor) references autor(id)
);

create table if not exists cliente (
	id integer primary key not null,
	nome varchar(100) not null,
	email varchar(100) not null,
	telefone varchar(11) not null
);

create table if not exists emprestimo (
	id integer primary key not null,
	dataEmprestimo date not null,
	dataDevolucao date not null,
	idcliente integer not null,
	foreign key(idcliente) references cliente(id)
);

create table if not exists emprestimo_por_livro (
	idemprestimo integer not null,
	idlivro integer not null,
	foreign key(idemprestimo) references emprestimo(id),
	foreign key(idlivro) references livro(id)
);


