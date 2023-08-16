Create Database Assesment04Db
use Assesment04Db
create table products
(PId int identity(500,1) primary key,
PName nvarchar(50) not null,
PPrice float,
PCompany nvarchar(50) check (PCompany in ('SamSung','Apple','Redmi','HTC','RealMe','Xiaomi')),
PQty int default(10) check (PQty>=1),
PTax as PPrice * 0.10 persisted,
)

insert into products values('Laptop','57000','samsung',2),('Mobile','25000','Apple',5)
insert into products(PName,PPrice,PCompany) values('Laptop','57000','Redmi')
insert into products values('Mobile','15000','RealMe',2),('Earpod','5000','Apple',3),('SmartWatch','2500','RealMe',1),
('Laptop','78000','HTC',1),('MacBook','99000','Apple',1)
insert into products(PName,PPrice,PCompany) values('Laptop','57000','HTC'),('Earpods','1200','Xiaomi')

select * from products
drop table products

create proc AllProducts
with encryption
as
select PId,PName,PCompany,PTax,
(PQty * PTax)as TotalPrice 
from products
exec AllProducts

create proc TotalTax
@totaltax float,
@pcompany nvarchar(50) output
as
 select @totaltax = SUM(PTax) from Products 
    where @pcompany = PCompany;
exec TotalTax 'RealMe',@totaltax output
print @totaltax
drop proc TotalTax
