create database if not exists clase2;
use clase2;

create table if not exists fabricantes (
codigo int not null, 
nombre nvarchar(100),
primary key (codigo)
);

create table if not exists articulos (
codigo int not null,
fabricante int,
nombre nvarchar (100),
precio int,
primary key (codigo),
foreign key (fabricante) references fabricantes(codigo)
);

insert into fabricantes (codigo, nombre) values
(1,'Sorny'),
(2, 'Fanasonic'),
(3, 'Perapad');

insert into articulos (codigo, fabricante, nombre, precio) values
(1, 1, 'Poly Station', 500),
(2, 2, "Tv oled 60''", 450),
(3,3, "Perapad 14", 750), 
(4, 1, 'Poly Station 5', 900),
(5, 2, "headPhones rs345", 150);
 

/* Consulta N°1 */
select nombre from articulos;

/* Consulta N°2 */
select nombre, precio from articulos;

/* Consulta N°3 */
select nombre, precio from articulos where precio <= 200;

/* Consulta N°4 */
select nombre, precio from articulos where precio between 60 and 120;

/* Consulta N°5 */
select nombre, precio * 85 as 'precio' from articulos;

/* Consulta N°6 */
select ( avg(precio), 1) from articulos;

/* Consulta N°7 */
select articulos.nombre, articulos.precio, fabricantes.nombre
from articulos, fabricantes
where fabricantes.codigo = articulos.codigo;


create table if not exists departamentos (
codigo int not null,
nombre nvarchar(100),
presupuesto int,
primary key (codigo)
);

create table if not exists empleados (
dni varchar(8) not null,
departamento int,
nombre nvarchar(100),
apellido nvarchar (255),
primary key (dni),
foreign key (departamento) references departamentos(codigo)
);

insert into departamentos (codigo, nombre, presupuesto) values 
(37, 'Depto 37', 50000),
(77, 'Depto 77', 45000);

insert into empleados (dni, nombre, apellido, departamento) values 
(42435380, 'Pablo', 'gerez', 37), 
(53789456, 'Sebastian', 'Lopez', 37), 
(35345345, 'Agustin', 'Perez', 77),
(44534344, 'Joaquin', 'Pettinari', 37);

/* Consulta N°8 */
select * from empleados
where apellido = 'Lopez' or apellido = 'Perez';

/* Consulta N°9 */
select * from empleados
where departamento = 37 or departamento = 77;

/* Consulta N°10 */
select empleados.nombre, empleados.apellido, departamentos.nombre, departamentos.presupuesto
from empleados, departamentos
where empleados.departamento = departamentos.codigo
order by departamentos.codigo;

/* Consulta N°11 */
select departamentos.nombre from departamentos, empleados
where departamentos.codigo = empleados.departamento
group by departamentos.nombre
having (sum(case when Empleados.CodigoDepartamento = Departamentos.CodigoDepartamento then 1 else 0 end)) >= 2;


/* Consulta N°12 */
insert into departamentos (codigo, nombre, presupuesto) values
(11, 'Calidad', 40000);

insert into empleados(dni, departamento, nombre, apellido) values
(89267109, 11, 'Esther', 'Vazquez');

/* Consulta N°13 */
update departamentos 
    set presupuesto = (presupuesto * 0.9);

create table if not exists almacenes (
    codigo int not null,
    lugar varchar (100),
    capacidad int,
    primary key(codigo)
);

CREATE TABLE IF NOT EXISTS cajas (
    codigo char(5) not null,
    almacen int,
    contenido varchar(100),
    valor int,
    foreign key (almacen) references almacenes(codigo)
);


insert into Almacenes(codigo, lugar, capacidad) values
(1, 'Ciudad  Gotica', 2), (2, 'Catamarca',2);

insert into cajas(codigo, almacen, contenido, valor) values
(1, 1, 'cigarrillos', 700), (2, 1, 'microfonos', 500), (3, 1, 'carretillas', 100), (4, 2, 'perros', 350);

/* Consulta N°14 */
select almacenes.lugar, count(cajas.codigo) as 'Cantidad de Cajas'
from almacenes, cajas
where cajas.almacen = almacenes.codigo
group by almacenes.lugar;


/*Consulta N°15 */
update cajas, almacenes
set cajas.almacen = null
where cajas.almacen in ((select count(cajas.codigo) from cajas, almacenes 
	where cajas.almacen = almacenes.codigo) > almacenes.capacidad);

    
    
    
    