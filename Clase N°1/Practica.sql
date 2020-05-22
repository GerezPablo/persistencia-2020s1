CREATE DATABASE if NOT EXISTS persistencia;
USE persistencia;

CREATE TABLE if NOT EXISTS departamentos (
	codDepto VARCHAR(4) NOT NULL,
	 nombreDepto VARCHAR(20),
	 ciudad VARCHAR(15),
	 codDirector VARCHAR(12),
	 PRIMARY KEY(codDepto)
);	

CREATE TABLE if NOT EXISTS empleados (
	nDIEmp VARCHAR(12) NOT NULL,
	codDepto VARCHAR(4),
	nomEmp VARCHAR(30),
	sexEmp VARCHAR(1),
	fecNac YEAR,
	fecIncorporacion YEAR,
	salEmp FLOAT,
	comisionEmp FLOAT,
	cargoEmp VARCHAR(12),
	jefeID VARCHAR(12),
	PRIMARY KEY(nDIEmp),
	FOREIGN KEY(codDepto) REFERENCES departamentos(codDepto)
);
insert into departamentos
values('1', 'Depto1', 'Hurlingang', '12');

insert into departamentos
values('2', 'Depto2', 'Moron city', '5');

insert into departamentos
values('3', 'DeptoVacio', 'Vice city', '1');
 
INSERT INTO empleados	
	VALUES('1','1','Pablo','m','2000','2008', '20000.00','5000.00','CEO','1');

INSERT INTO empleados	
	VALUES('2','2','Joaquin','m','1932','2017', '15000.00','0.00','pichi','1');
    
INSERT INTO empleados	
	VALUES('3','2','Florchu','f','1600','2015', '7000.00','10000.00','barrendera','1');    

INSERT INTO empleados	
	VALUES('4','1','Ayena','f','1890','2000', '7000.00','10000.00','barrendera','1');    
    
INSERT INTO empleados	
	VALUES('5','2','Mandarina','m','2019','2020', '80001.00','10000.00','ventas','1'); 

INSERT INTO empleados	
	VALUES('6','2','Manzana','f','2018','2020', '80.00','850000.00','ventas','1'); 

/*Consulta N°1*/    
select *  from empleados; 

/*Consulta N°2*/
select nombreDepto as "Nombre Departamento" from departamentos; 

/*Consulta N°3*/
select nomEmp, cargoEmp,salEmp from empleados
ORDER BY salEmp DESC;

/*Consulta N°4*/
select nomEmp from empleados
where comisionEmp > salEmp;

/*Consulta N°5*/
select * from empleados 
where comisionEmp <= (salEmp * 0.3);

/*Consulta 6*/
select nomEmp as "Empleado", cargoEmp as "Cargo" from empleados
where nomEmp between"j%" and "z%"
order by cargoEmp asc;

/*Consulta 7*/
select nomEmp as "Empleado" from empleados
where not nomEmp like "%na%";

/*Consulta 8*/
select nomEmp as "Empleado" from empleados
where nomEmp like "m%" and (salEmp >= 800000 or comisionEmp >= 800000) and cargoEmp = "ventas";

/*Consulta N°9*/
select nomEmp as "Empleado", salEmp as "Sueldo" from empleados
order by salEmp  asc limit 1;

/*Consulta N°10*/
select max(salEmp) as "Salario Maximo", min(salEmp) as "Salario Minimo", (max(salEmp) - min(salEmp)) as "Diferencia" from empleados;

/*Consulta N°11*/
select departamentos.codDepto, empleados.sexEmp as "Sexo", COUNT(empleados.nomEmp) as "Cantidad" from empleados,departamentos
Where departamentos.codDepto = empleados.codDepto
group by departamentos.codDepto, empleados. sexEmp;

/*Consulta N°12*/
select departamentos.nombreDepto as 'Departamento', count(empleados.nomEmp) as "CantEmpleados" from empleados, departamentos 
where departamentos.codDepto = empleados.codDepto
group by departamentos.codDepto
having CantEmpleados >= 3;

/*Consulta N°13*/
select empleados.jefeID as CodigoJefe, empleados.nomEmp as 'NombreJefe', 
(select count(*) -1 from empleados where empleados.jefeID = CodigoJefe) as CantEmpleados
 from empleados
where empleados.jefeID = empleados.nDIEmp
group by empleados.jefeID
having CantEmpleados >= 2;


/*Consulta N°14*/
select departamentos.nombreDepto as 'Departamento', 
sum(case when empleados.codDepto = departamentos.codDepto then 1 else 0 end) as cantEmpleados from empleados, departamentos 
group by departamentos.nombreDepto
having cantEmpleados < 1;

/*Consulta N° 15*/
Select departamentos.nombreDepto as 'Departamento', sum(empleados.salEmp) as SalarioTotal from departamentos, empleados 
where empleados.codDepto = departamentos.codDepto
group by departamentos.nombreDepto
limit 1;