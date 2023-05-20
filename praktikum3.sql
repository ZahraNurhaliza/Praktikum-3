create database praktikum3;
use praktikum3;

create table Mahasiswa (
  nim varchar(10) primary key,
  nama varchar(50) not null,
  jenis_kelamin enum('Laki-laki', 'Perempuan') not null,
  tgl_lahir date not null,
  jalan varchar(100) default null,
  kota varchar(50) default null,
  kodepos varchar(10) default null,
  no_hp varchar(20) default null,
  kd_ds varchar(10) default null,
  constraint FK_DosenWali foreign key (kd_ds) references Dosen(kd_ds)
);

create table Dosen (
  kd_ds varchar(10) primary key,
  nama varchar(50) not null
);

create table MataKuliah (
  kd_mk varchar(10) primary key,
  nama varchar(50) not null,
  sks int not null
);

create table JadwalMengajar (
  kd_ds varchar(10) not null,
  kd_mk varchar(10) not null,
  hari enum('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu') not null,
  jam time not null,
  ruang varchar(20) not null,
  primary key (kd_ds, kd_mk, hari, jam),
  constraint FK_JadwalDosen foreign key (kd_ds) references Dosen(kd_ds),
  constraint FK_JadwalMatakuliah foreign key (kd_mk) references MataKuliah(kd_mk)
);

create table KRSMahasiswa (
  nim varchar(10) not null,
  kd_mk varchar(10) not null,
  kd_ds varchar(10) not null,
  semester varchar(10) not null,
  nilai DECIMAL(4,2) not null,
  primary key (nim, kd_mk),
  constraint FK_KRSMahasiswa foreign key (nim) references Mahasiswa(nim),
  constraint FK_KRSMataKuliah foreign key (kd_mk) references MataKuliah(kd_mk),
  constraint FK_KRSDosen foreign key (kd_ds) references Dosen(kd_ds)
);

insert into Dosen (kd_ds, nama) values
('DS001', 'Johnny'),
('DS002', 'Jake'),
('DS003', 'Hanny'),
('DS004', 'Karina'),
('DS005', 'Eric');
select * from Dosen;

insert into Mahasiswa (nim, nama, jenis_kelamin, tgl_lahir, jalan, kota, kodepos, no_hp, kd_ds) values
('11223344', 'Ari Santoso', 'Laki-laki', '1979-08-31', NULL, 'Bekasi', NULL, NULL, 'DS001'),
('11223345', 'Ario Talib', 'Laki-laki', '1999-11-16', NULL, 'Cikarang', NULL, NULL, 'DS002'),
('11223347', 'Lisa Ayu', 'Perempuan', '1996-01-02', NULL, 'Bekasi', NULL, NULL, 'DS003'),
('11223348', 'Tiara Wahidah', 'Perempuan', '1908-02-05', NULL, 'Bekasi', NULL, NULL, 'DS004'),
('11223349', 'Anton Sinaga', 'Laki-laki', '1988-03-10', NULL, 'Cikarang', NULL, NULL, 'DS005');
select * from Mahasiswa;

delete from Dosen where kd_ds = 'DS002';

alter table Mahasiswa drop foreign key FK_DosenWali;
alter table Mahasiswa add constraint FK_DosenMahasiswa foreign key (kd_ds) references Dosen(kd_ds) on update cascade on delete restrict;

update Dosen set kd_ds = 'DS007' where kd_ds = 'DS005';

delete from Dosen where kd_ds = 'DS001';

alter table Mahasiswa drop foreign key FK_DosenMahasiswa;
alter table Mahasiswa add constraint FK_DosenWali foreign key (kd_ds) references Dosen(kd_ds) on update cascade on delete set null;

delete from Dosen where kd_ds = 'DS004';