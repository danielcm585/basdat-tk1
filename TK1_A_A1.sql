create schema tk1_a1;

set search_path to tk1_a1;

create table user (
	email varchar(50) not null,
  password varchar(50) not null,
  phonenum varchar(20) not null,
  fname varchar(15) not null,
  lname varchar(14) not null,
  primary key (email)
);

create table admin (
	email varchar(50) not null,
  primary key (email),
  foreign key (email) references user (email) on delete cascade on update cascade
);

create table transaction_actor(
	email varchar(50) not null,
	nik varchar(20) not null,
	bankname varchar(20) not null,
	accountno varchar(20) not null,
	restopay varchar(20) default 0,
	adminid varchar(50) not null,
  primary key (email),
  foreign key (email) references user (email) on delete cascade on update cascade,
  foreign key (adminid) references admin (email) on delete cascade on update cascade
);

CREATE TABLE COURIER (
		email varchar(50) not null,
		platenum varchar(10) not null,
		drivinglicensenum varchar(20) not null,
		vechicletype varchar(15) not null,
		vehiclebrand varchar(15) not null,
		PRIMARY KEY (email),
		FOREIGN KEY (email) REFERENCES TRANSACTION_ACTOR(email) ON UPDATE CASCADE ON DELETE CASCADE
);

create table customer (
	email varchar(50) not null,
	birthdate date not null,
  sex char(1) not null,
  primary key (email),
  foreign key (email) references transaction_actor (email) on delete cascade on update cascade
);

CREATE TABLE RESTAURANT_CATEGORY(
		id varchar(20) not null,
		name varchar(50) not null,
		PRIMARY KEY (id)
);

create table restaurant (
	rname varchar(25) not null,
  rbranch varchar(25) not null,
  email varchar(50),
  rphonenum varchar(18) not null,
  street varchar(30) not null,
  district varchar(20) not null,
  city varchar(20) not null,
  province varchar(20) not null,
  rating integer default 0,
  rcategory varchar(20),
  primary key (rname, rbranch),
  foreign key (email) references transaction_actor (email) on delete cascade on update cascade,
  foreign key (rcategory) references restaurant_category (id) on delete cascade on update cascade,
  check (rating >= 0),
  check (rating <= 10)
);

create table restaurant_operating_hours (
	name varchar(25) not null,
	branch varchar(25) not null,
	day varchar(10) not null,
	starthours time not null,
	endhours time not null,
	primary key (name, branch, day),
	foreign key (name, branch) references restaurant (rname, rbranch) on delete cascade on update cascade
);

create table food_category(
	id varchar(20) not null,
	name varchar(50) not null,
	primary key (id)
);

create table food(
	rname varchar(25) not null,
	rbranch varchar(25) not null,
	foodname varchar(50) not null,
	description text,
	stock varchar(15) not null,
	price bigint not null,
	fcategory varchar(20) not null,
	primary key (rname, rbranch, foodname)
	foreign key (rname, rbranch) references restaurant (rname, rbranch) on delete cascade on update cascade
);

CREATE TABLE INGREDIENT(
		id varchar(25) not null,
		name varchar(25) not null,
		PRIMARY KEY (id)
);

CREATE TABLE FOOD_INGRIDIENT(
		rname varchar(25) not null,
		rbranch varchar(25) not null,
		foodname varchar(50) not null,
		ingredient varchar(25) not null,
		PRIMARY KEY (rname),
		FOREIGN KEY (rname) REFERENCES FOOD (rname) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (rbranch) REFERENCES FOOD (rbranch) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (foodname) REFERENCES FOOD (foodname) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (ingredient) REFERENCES INGREDIENT (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PAYMENT_METHOD(
		id varchar(25) not null,
		name varchar(25) not null,
		PRIMARY KEY (id)
);

CREATE TABLE PAYMENT_STATUS(
		id varchar(25) not null,
		name varchar(25) not null,
		PRIMARY KEY (id)
);

create table delivery_fee_per_km(
	id varchar(20) not null,
	province varchar(25) not null,
	motorfee int not null,
	carfee int not null,
	primary key (id)
);

create table transaction (
	email varchar(50) not null,
	datetime timestamp not null,
	street varchar(30) not null,
  district varchar(30) not null,
  city varchar(25) not null,
  province varchar(25) not null,
  totalfood integer not null,
  totaldiscount float not null,
  deliveryfee float not null,
  totalprice float not null,
  rating integer not null,
  pmid varchar(25) not null,
  psid varchar(25) not null,
  dfid varchar(20) not nul,
  courierid varchar(50) not null,
  primary key (email, datetime),
  foreign key (pmid) references payment_method (id) on delete cascade on update cascade,
  foreign key (psid) references payment_status (id) on delete cascade on update cascade,
  foreign key (dfid) references delivery_fee_per_km (id) on delete cascade on update cascade,
  foreign key (courierid) references courier (id) on delete cascade on update cascade
);

CREATE TABLE TRANSACTION_STATUS(
		id varchar(25) not null,
		name varchar(25) not null,
		PRIMARY KEY (id)
);

create table transaction_food(
	email varchar(50) not null,
	datetime datetime not null,
	rname varchar(25) not null,
	rbranch varchar(25) not null,
	foodname varchar(50) not null,
	amount int not null,
	note varchar(255),
	primary key (email, datetime, rname, branch, foodname),
	foreign key (email, datetime) references transaction (email, datetime) on delete cascade on update cascade,
	foreign key (rname, rbranch, foodname) references food (rname, rbranch, foodname) on delete cascade on update cascade
);

CREATE TABLE TRANSACTION_HISTORY(
		email varchar(50) not null,
		datetime DATETIME not null,
		tsid varchar(25) not null,
		datetimestatus varchar(20,
		PRIMARY KEY (email, datetime, tsid),
		FOREIGN KEY (email) REFERENCES TRANSACTION (email) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (datetime) REFERENCES TRANSACTION_FOOD (datetime) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (tsid) REFERENCES TRANSACTION_STATUS (id) ON UPDATE CASCADE ON DELETE CASCADE
);

create table promo (
	id varchar(25) not null,
	promoname varchar(25) not null,
	discount integer not null,
	primary key (id),
	check (discount > 0),
  check (discount <= 100)
);

create table min_transaction_promo (
	id varchar(25) not null,
	minimumtransactionnum integer not null,
	primary key (id),
  foreign key (id) references promo (id) on delete cascade on update cascade
);

create table special_day_promo (
	id varchar(25) not null,
	date datetime not null,
	primary key (id),
	foreign key (id) references promo (id) on delete cascade on update cascade
)

create table restaurant_promo (
	rname varchar(25) not null,
  rbranch varchar(25) not null,
  pid varchar(25),
  start datetime not null,
  end datetime not null,
  primary key (rname, rbranch),
  foreign key (rname, rbranch) references food (rname, rbranch) on delete cascade on update cascade,
  foreign key (pid) references promo (id) on delete cascade on update cascade
);

\d USER
\d ADMIN
\d TRANSACTION_ACTOR
\d COURIER
\d CUSTOMER
\d RESTAURANT
\d RESTAURANT_OPERATING_HOURS
\d RESTAURANT_CATEGORY
\d FOOD_CATEGORY
\d FOOD
\d INGREDIENT
\d FOOD_INGREDIENT
\d TRANSACTION
\d DELIVERY_FEE_PER_KM
\d PAYMENT_METHOD
\d PAYMENT_STATUS
\d TRANSACTION_STATUS
\d TRANSACTION_FOOD
\d TRANSACTION_HISTORY
\d PROMO
\d MIN_TRANSACTION_PROMO
\d SPECIAL_DAY_PROMO
\d RESTAURANT_PROMO

insert into user values
  ('Tess_Labadie@gmail.com','=,Vel#Y5i0','187391110913120','Tess','Labadie'),
  ('Jayme_Murray@gmail.com','!9Tr/&;FNxUiXb$','8637811956780','Jayme','Murray'),
  ('Prof._William@gmail.com','rdN@}R\wk9^','10011556420181','Prof.','William'),
  ('Hector_Gerlach@gmail.com','wMWECU!RYe@','394310888842775','Hector','Gerlach'),
  ('Steve_Rogahn@gmail.com','84`Gx|(w$','6417562136','Steve','Rogahn'),
  ('Dulce_Bashirian@gmail.com','tz$i%BU_Rl.FukZL`o','7511635703','Dulce','Bashirian'),
  ('Savanna_Tillman@gmail.com','7DOM`uDz8WJNhuF%$r','6723844081','Savanna','Tillman'),
  ('Kelton_Gorczany@gmail.com','TA?%kL'iUH^p%x3+ci)\','4981676376','Kelton','Gorczany'),
  ('Vergie_Grimes@gmail.com','MPx^\$ZuI)I(}8.f,@mT','330600655279527','Vergie','Grimes'),
  ('Prof._Brennon@gmail.com','4s@W0WC=CZZ','81394164654913','Prof.','Brennon'),
  ('Elfrieda_Wilderman@gmail.com','L[V%S:(Zf.c!F}zl','08037314871','Elfrieda','Wilderman'),
  ('Eula_Mayert@gmail.com','OGt:k+QNYHaP=-[','13058346522','Eula','Mayert'),
  ('Hosea_Swaniawski@gmail.com','h%sC+?bv`7%y]$!+[','9666646214','Hosea','Swaniawski'),
  ('Veda_Watsica@gmail.com','v6*wrD7k%qE6ZT)','16650313125','Veda','Watsica'),
  ('Edyth_Lindgren@gmail.com','+FqU$VKv?{c4','7840484406','Edyth','Lindgren'),
  ('Mr._Kaleb@gmail.com','XbCj2]HaHo_GB9Rt^','06405529831','Mr.','Kaleb'),
  ('General_Brekke@gmail.com',':W(OU#&fgN#xE','934396778485938','General','Brekke'),
  ('Ms._Adell@gmail.com','cBexgjy%'eNNs','171066371771175','Ms.','Adell'),
  ('Orpha_Leannon@gmail.com','qwRj$"Z?"#{Nix','094782183032129','Orpha','Leannon'),
  ('Mr._Karl@gmail.com','js)69.WM:','7409848604604','Mr.','Karl'),
  ('Andreanne_Johnson@gmail.com','*|@421Q28m4ea:CSuV','5510849680','Andreanne','Johnson'),
  ('Prof._Darrell@gmail.com','tVGk4zM9FF','337737866307916','Prof.','Darrell'),
  ('Shaina_Barton@gmail.com',')22zg`0~@W%i!=/6','6278279372238','Shaina','Barton'),
  ('Mr._Curt@gmail.com','[TBRjIto#'FaZH`Ri','146790602884309','Mr.','Curt'),
  ('Taya_King@gmail.com','Pa5xmusz0B7h8Zj','5984909264771','Taya','King'),
  ('Ms._Zola@gmail.com','[6?)X*C'f:0.NA0','06123025469','Ms.','Zola'),
  ('Curt_Schneider@gmail.com','0_9g*H0v[FE','8731439350273','Curt','Schneider'),
  ('Jovani_Ernser@gmail.com','KuDSG_-+h','1624654063684','Jovani','Ernser'),
  ('Prof._Maddison@gmail.com','\8l8,Q$7Pq,N;K-IAB','5279956558290','Prof.','Maddison'),
  ('Soledad_Doyle@gmail.com','v1_K9;5FkhV0{','232808755497898','Soledad','Doyle');

insert into admin values
  ('Tess_Labadie@gmail.com'),
  ('Jayme_Murray@gmail.com'),
  ('Prof._William@gmail.com'),
  ('Hector_Gerlach@gmail.com'),
  ('Steve_Rogahn@gmail.com');

insert into transaction_actor values
  ('Tess_Labadie@gmail.com',’9598152786155006’,’BCA’,’AP001’,’1000’,’'Steve_Rogahn@gmail.com'),
  ('Jayme_Murray@gmail.com',’4099051481435243’,’BNI’,’AP002’,’2500’,’Hector_Gerlach@gmail.com'),
  ('Prof._William@gmail.com',’6359075340969926’,’Mandiri’,’AP003’,’5000’,’Prof._William@gmail.com'),
  ('Hector_Gerlach@gmail.com’,’2504404782329784’,’BRI’,’AP004’,’7500’,’Jayme_Murray@gmail.com'),
  ('Steve_Rogahn@gmail.com',’2391967585323301’,	‘BRI’,’BR001’,’3000’,’Tess_Labadie@gmail.com'),
  ('Dulce_Bashirian@gmail.com',’9018344908528880’,’Mandiri’,’BR002’,’12500’,’Tess_Labadie@gmail.com'),
  ('Savanna_Tillman@gmail.com',’3324396477521421’,’BNI’,’BR003’,’14000’,’Jayme_Murray@gmail.com'),
  ('Kelton_Gorczany@gmail.com',’3537085869758208’,’BCA’,’BR004’,’11500’,’Jayme_Murray@gmail.com'),
  ('Vergie_Grimes@gmail.com',’9816226837961717’,’Mandiri’,’MT001’,’8000’,’Prof._William@gmail.com'),
  ('Prof._Brennon@gmail.com',’1373111413809307’,’BNI’,’MT002’,’15000’,’Hector_Gerlach@gmail.com'),
  ('Elfrieda_Wilderman@gmail.com',’2223509872730385’,’BRI’,’MT003’,’9000’,’Steve_Rogahn@gmail.com'),
  ('Eula_Mayert@gmail.com',’1723561993508037’,’BCA’,’MT004’,’17000’,’Tess_Labadie@gmail.com'),
  ('Hosea_Swaniawski@gmail.com',’3407707125351288’,’BRI’,’RB001’,’20500’,’Jayme_Murray@gmail.com'),
  ('Veda_Watsica@gmail.com',’1663046385997304’,’Mandiri’,’RB002’,’22000’,’Prof._William@gmail.com'),
  ('Edyth_Lindgren@gmail.com',’3110181921568232’,’BNI’,’RB003’,’21000’,’Hector_Gerlach@gmail.com'),
  ('Mr._Kaleb@gmail.com',’3059891267826887’,’BRI’,’RB004’,’16500’,’Steve_Rogahn@gmail.com'),
  ('General_Brekke@gmail.com',’7012213860777765’,’BNI’,’RM001’,’16000’,’Tess_Labadie@gmail.com'),
  ('Ms._Adell@gmail.com',’2340615048226353’,’BCA’,’RM002’,’34000’,’Jayme_Murray@gmail.com'),
  ('Orpha_Leannon@gmail.com',’0797607930131113’,’Mandiri’,’RM003’,’1500’,’Prof._William@gmail.com'),
  ('Mr._Karl@gmail.com',’5745855617446235’,’BRI’,’RM004’,’9500’,’Hector_Gerlach@gmail.com');

insert into courier values
  ('Hector_Gerlach@gmail.com','BPKJ07','00000000000003','Toyota Rav4 Le','Toyota'),
  ('Savanna_Tillman@gmail.com','F91LGN','00000000000006','Acura Rdx ','Acura'),
  ('Kelton_Gorczany@gmail.com','4HQN216','00000000000007','Honda Civic Lx','Honda'),
  ('Vergie_Grimes@gmail.com','DCK7853','00000000000008','Chevrolet Sonic Lt','Chevrolet'),
  ('Eula_Mayert@gmail.com','5RIN076','00000000000011','Ford Explorer','Ford');

insert into customer values
  ('Tess_Labadie@gmail.com',’05/06/1986’,’P’),
  ('Jayme_Murray@gmail.com','02/03/1989’,’L’),
  ('Prof._William@gmail.com',’12/04/1983’,’L’),
  ('Hector_Gerlach@gmail.com’,’14/06/1998’,’L’),
  ('Steve_Rogahn@gmail.com',’09/08/1994’,’L’),
  ('Dulce_Bashirian@gmail.com',’19/07/1988’,’L’),
  ('Savanna_Tillman@gmail.com',’17/12/1999’,’P’),
  ('Kelton_Gorczany@gmail.com',’24/08/1995’,’L’),
  ('Vergie_Grimes@gmail.com',’06/05/1984’,’P’),
  ('Prof._Brennon@gmail.com',’08/05/2002’,’L’),
  ('Elfrieda_Wilderman@gmail.com',’12/06/1985’,’P’),
  ('Eula_Mayert@gmail.com',’09/08/1983’,’P’),
  ('Hosea_Swaniawski@gmail.com',’18/08/1991’,’P’),
  ('Veda_Watsica@gmail.com',’04/08/1986’,’P’),
  ('Edyth_Lindgren@gmail.com',’06/08/1999’,’P’),
  ('Mr._Kaleb@gmail.com',’15/01/2000’,’L’),
  ('General_Brekke@gmail.com',’30/08/1997’,’L’),
  ('Ms._Adell@gmail.com',’30/11/1989’,’P’),
  ('Orpha_Leannon@gmail.com',’20/01/1991’,’L’),
  ('Mr._Karl@gmail.com',’11/11/1998’,’L’);

insert into ingredient values
  ('0000000000000000000000000','fennel seed'),
  ('0000000000000000000000001','garlic powder'),
  ('0000000000000000000000002','cranberry'),
  ('0000000000000000000000003','lemonade'),
  ('0000000000000000000000004','cantaloupe'),
  ('0000000000000000000000005','soy milk'),
  ('0000000000000000000000006','passion fruit'),
  ('0000000000000000000000007','kiwi fruit'),
  ('0000000000000000000000008','lemonade'),
  ('0000000000000000000000009','walnut'),
  ('0000000000000000000000010','mustard seeds'),
  ('0000000000000000000000011','salsa'),
  ('0000000000000000000000012','saffron'),
  ('0000000000000000000000013','walnut'),
  ('0000000000000000000000014','snap pea'),
  ('0000000000000000000000015','cornmeal'),
  ('0000000000000000000000016','cilantro'),
  ('0000000000000000000000017','zinfandel wine'),
  ('0000000000000000000000018','strawberry'),
  ('0000000000000000000000019','cranberry'),

