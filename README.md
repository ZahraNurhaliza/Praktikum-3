# Praktikum-3

 ## Script DDL (Seperti Praktikum2)
 ``` python
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
```


## Tugas Praktikum 3
1.	Lakukan penambahan data pada table mahasiswa dengan mengisi kd_ds yang belum ada pada data dosen.
``` python
insert into Dosen (kd_ds, nama) values
('DS001', 'Chanyeol'),
('DS002', 'Jaemin'),
('DS003', 'Jisung'),
('DS004', 'NingNing'),
('DS005', 'Yuta');
select * from Dosen;

insert into Mahasiswa (nim, nama, jenis_kelamin, tgl_lahir, jalan, kota, kodepos, no_hp, kd_ds) values
('11223344', 'Ari Santoso', 'Laki-laki', '1979-08-31', NULL, 'Bekasi', NULL, NULL, 'DS001'),
('11223345', 'Ario Talib', 'Laki-laki', '1999-11-16', NULL, 'Cikarang', NULL, NULL, 'DS002'),
('11223347', 'Lisa Ayu', 'Perempuan', '1996-01-02', NULL, 'Bekasi', NULL, NULL, 'DS003'),
('11223348', 'Tiara Wahidah', 'Perempuan', '1908-02-05', NULL, 'Bekasi', NULL, NULL, 'DS004'),
('11223349', 'Anton Sinaga', 'Laki-laki', '1988-03-10', NULL, 'Cikarang', NULL, NULL, 'DS005');
select * from Mahasiswa;
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.1png)
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.2png)


2.	Hapus satu record data pada table dosen yang telah dirujuk pada table mahasiswa.
``` python
delete from Dosen where kd_ds = 'DS002';
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.3png)
Keterangan : Terjadi error dikarenakan `kd_ds` pada tabel Mahasiswa merupakan 
FOREIGN KEY dari tabel refensinya yaitu tabel Dosen. Dan pada tabel Dosen 
`kd_ds` merupakan PRIMARY KEY. Itu artinya, tabel Dosen sebagai tabel 
parent/references dan Mahasiswa sebagai tabel child maka dari itu saat 
menghapus satu record data pada tabel dosen terjadi error

3.	Ubah mode menjadi ON UPDATE CASCADE ON DELETE RESTRICT
``` python
alter table Mahasiswa drop foreign key FK_DosenWali;
alter table Mahasiswa add constraint FK_DosenMahasiswa foreign key (kd_ds) references Dosen(kd_ds) on update cascade on delete restrict;
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.4png)


4.	Lakukan perubahan data pada table dosen (kd_ds)
```python
update Dosen set kd_ds = 'DS007' where kd_ds = 'DS005';
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.5png)


5.	Lakukan penghapusan data pada table dosen
```python
delete from Dosen where kd_ds = 'DS001';
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.6png)
Keterangan : Terjadi ERROR 
 
6.	Ubah mode menjadi ON UPDATE CASCADE ON DELETE SET NULL
```python
alter table Mahasiswa drop foreign key FK_DosenMahasiswa;
alter table Mahasiswa add constraint FK_DosenWali foreign key (kd_ds) references Dosen(kd_ds) on update cascade on delete set null;
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.7png)

 
7.	Lakukan penghapusan data pada table dosen
```python
delete from Dosen where kd_ds = 'DS004';
```
![image](https://github.com/ZahraNurhaliza/Praktikum3/blob/main/screenshot/1.8png)


## Evaluasi dan Pertanyaan

• Apa bedanya penggunaan RESTRICT dan penggunaan CASCADE
•	RESTRICT 
Dalam konteks pembaruan, jika ada entri dalam tabel induk yang memiliki entri terkait dalam tabel anak, pembaruan tidak akan diizinkan sampai referensi tersebut dihapus atau diubah.

•	CASCADE
Dalam konteks pembaruan, jika nilai pada kolom referensi dalam tabel induk diubah, maka nilai pada kolom referensi dalam tabel anak yang terkait juga akan berubah sesuai.

• Berikan kesimpulan anda!
RESTRICT digunakan untuk mencegah tindakan jika ada keterkaitan antara tabel, sementara CASCADE digunakan untuk memberikan efek pada tabel terkait secara otomatis saat tindakan dilakukan pada tabel utama.

• Buat laporan praktikum yang berisi, langkah-langkah praktikum beserta screenshot yang sudah dilakukan dalam bentuk dokumen.
[Link Google Drive](https://drive.google.com/file/d/1mFOUhFiJrmo7w5DR1321C2DwjiERukhE/view?usp=sharing)
