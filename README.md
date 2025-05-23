# Telecommunication Operator Data Analysis and Processing

## Project Overview
Proyek ini bertujuan untuk menganalisis dan memproses data roaming operator telekomunikasi. Data diolah untuk mendapatkan wawasan tentang kinerja operator dan negara dalam menyediakan layanan roaming, dengan berbagai metrik yang dianalisis seperti jumlah pengguna aktif, lalu lintas data, tingkat keberhasilan sesi, dan latensi.

## Features
- **Analisis Data Mentah**: Memproses dan membersihkan data untuk meningkatkan akurasi.
- **Penyimpanan dalam Database**: Memasukkan data ke dalam PostgreSQL.
- **Fungsi Database**:
  - Menampilkan daftar semua negara
  - Menampilkan daftar operator berdasarkan negara
  - Menampilkan metrik roaming berdasarkan negara dan operator
  - Menghitung skor dan memberikan peringkat terhadap negara berdasarkan performa roaming
  - Menentukan lima operator terburuk di setiap negara

## Data Overview
Terdapat tiga jenis file data harian yang diolah:

<img src="https://github.com/zareee12/Outbound-Roaming-Data-Analysis-and-Processing/blob/main/images/overview.png" alt="Overview" width="650"/>

| Kode | Deskripsi |
|------|------------------------------------|
| **01** | Data agregat berdasarkan negara dan operator |
| **02** | Data agregat berdasarkan operator |
| **03** | Data mentah harian outbound |

Setiap file memiliki header berikut:
```
datedd, OPERATOR_NAME, COUNTRY_NAME, Numuser, active_user, Trafficmb,
Session, duration_s, s5s8_create_session_success_rate, s6a_loc_update_success_rate
```

Pada 7 Januari 2025, ditambahkan 4 header baru:
```
dl_retransmitted_packet_rate, ul_retransmitted_packet_rate, internal_latency, external_latency
```

## Data Processing Workflow
![Workflow](https://github.com/zareee12/Outbound-Roaming-Data-Analysis-and-Processing/blob/main/flow%20diagram.jpg)

### 1. Data Preparation
- Menambahkan 4 kolom baru untuk kompatibilitas
- Menggabungkan file berdasarkan kategori (01, 02, 03)

<img src="https://github.com/zareee12/Outbound-Roaming-Data-Analysis-and-Processing/blob/main/images/preparation.png" alt="preparation" width="650"/>

### 2. Insert Data
Data dimasukkan ke PostgreSQL menggunakan shell scripts dengan tiga tabel:

<img src="https://github.com/zareee12/Outbound-Roaming-Data-Analysis-and-Processing/blob/main/images/insert%20data.png" alt="insert data" width="650"/>

| Tabel | Deskripsi |
|----------------------------|--------------------------------------------|
| `01_Outbond_Roamer_Overal_Daily` | Data agregat roaming berdasarkan negara dan operator |
| `02_Outbond_Roamer_Country_Daily` | Data agregat roaming berdasarkan operator |
| `03_Outbond_Roamer_Country_Operator_Daily` | Data roaming mentah per operator dan negara |

### 3. Data Manipulation
- Membersihkan data dengan standarisasi nama negara dan operator
- Menghapus data terkait Indonesia untuk fokus pada roaming outbound
- Menambahkan kolom baru untuk scoring, seperti `continent`, `weight1` - `weight6`, `final_score`, dan `remark`
- Menghitung skor berdasarkan formula bobot
- Mengelompokkan negara berdasarkan benua

<img src="https://github.com/zareee12/Outbound-Roaming-Data-Analysis-and-Processing/blob/main/images/data%20manipulation.png" alt="Data Manipulation" width="850"/>

### 4. Data Normalization
- Memecah data menjadi 4 tabel untuk efisiensi:

| Tabel | Deskripsi |
|-----------------------------|------------------------------------------|
| **Country** | Negara & benua |
| **Operator** | Operator per negara |
| **Roaming Data** | Penggunaan roaming |
| **Roaming Data Score Remark** | Skor & penilaian |

## Database Functions
Beberapa fungsi utama dalam database PostgreSQL:

| Fungsi | Deskripsi |
|---------------------------------|--------------------------------------------------|
| `get_all_countries()` | Mengambil daftar semua negara |
| `get_all_operators(country_name)` | Mengambil daftar operator dengan opsi filter berdasarkan negara |
| `get_country_operator_metrics(start_date, end_date, country_name, operator_name)` | Mengambil metrik roaming |
| `get_countries_with_score(start_date, end_date)` | Menghitung skor negara berdasarkan metrik roaming |
| `get_worst_operators(start_date, end_date)` | Menampilkan 5 operator terburuk di setiap negara |

## Tools & Technologies
- **Database**: PostgreSQL
- **ETL Tools**: DBeaver
- **Programming**: SQL
- **Data Processing**: Python, Pandas

## Contributors
- **Reza Septian Kamajaya** (Project Presenter)


