alter table aauthor_abook drop constraint FK845989F746975061;
alter table aauthor_abook drop constraint FK845989F75784C0AC;
alter table aface drop constraint FK586BE3E76389FED;
alter table bbook drop constraint FK5933A4BC54676E;
alter table bface drop constraint FK594D5BF7646B76E;
alter table cauthor_books drop constraint FK617396D9B9A161AC;
alter table cauthor_books drop constraint FK617396D92763496C;
alter table cnose drop constraint FK5A6C6B6B659CAAF;
drop table aauthor if exists;
drop table aauthor_abook if exists;
drop table abook if exists;
drop table aface if exists;
drop table anose if exists;
drop table bauthor if exists;
drop table bbook if exists;
drop table bface if exists;
drop table bnose if exists;
drop table cauthor if exists;
drop table cauthor_books if exists;
drop table cbook if exists;
drop table cface if exists;
drop table cnose if exists;
drop table versionado if exists;
create table aauthor (id bigint generated by default as identity, version bigint not null, name varchar(255) not null, primary key (id));
create table aauthor_abook (aauthor_books_id bigint, abook_id bigint);
create table abook (id bigint generated by default as identity, version bigint not null, title varchar(255) not null, primary key (id));
create table aface (id bigint generated by default as identity, version bigint not null, nose_id bigint not null, primary key (id));
create table anose (id bigint generated by default as identity, version bigint not null, primary key (id));
create table bauthor (id bigint generated by default as identity, version bigint not null, name varchar(255) not null, primary key (id));
create table bbook (id bigint generated by default as identity, version bigint not null, author_id bigint not null, title varchar(255) not null, primary key (id));
create table bface (id bigint generated by default as identity, version bigint not null, nose_id bigint not null, primary key (id));
create table bnose (id bigint generated by default as identity, version bigint not null, primary key (id));
create table cauthor (id bigint generated by default as identity, version bigint not null, name varchar(255) not null, primary key (id));
create table cauthor_books (cauthor_id bigint not null, cbook_id bigint not null, primary key (cauthor_id, cbook_id));
create table cbook (id bigint generated by default as identity, version bigint not null, title varchar(255) not null, primary key (id));
create table cface (id bigint generated by default as identity, version bigint not null, primary key (id));
create table cnose (id bigint generated by default as identity, version bigint not null, face_id bigint not null unique, primary key (id));
create table versionado (id bigint generated by default as identity, version bigint not null, valor integer not null, primary key (id));
alter table aauthor_abook add constraint FK845989F746975061 foreign key (aauthor_books_id) references aauthor;
alter table aauthor_abook add constraint FK845989F75784C0AC foreign key (abook_id) references abook;
alter table aface add constraint FK586BE3E76389FED foreign key (nose_id) references anose;
alter table bbook add constraint FK5933A4BC54676E foreign key (author_id) references bauthor;
alter table bface add constraint FK594D5BF7646B76E foreign key (nose_id) references bnose;
alter table cauthor_books add constraint FK617396D9B9A161AC foreign key (cauthor_id) references cauthor;
alter table cauthor_books add constraint FK617396D92763496C foreign key (cbook_id) references cbook;
alter table cnose add constraint FK5A6C6B6B659CAAF foreign key (face_id) references cface;
