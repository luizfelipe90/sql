/*modificador  e melhorando o banco */ 
/*renomeando colunas*/ 

alter table clientes
change column telefone celular varchar (15); 


rename table cliente to usuario; 

   
alter table  usuarios 
add column telefone varchar (12) after email;  
