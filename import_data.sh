#!/bin/bash

# Konfigurasi Database
DB_NAME="postgres"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"
SCHEMA_NAME="roaming_data"
export PGPASSWORD="1234"

# Menambahkan PostgreSQL ke PATH jika belum ada
if ! command -v psql &> /dev/null; then
    export PATH="/c/Program Files/PostgreSQL/17/bin:$PATH"
fi

# Cek apakah psql tersedia
if ! command -v psql &> /dev/null; then
    echo "❌ ERROR: psql tidak ditemukan! Pastikan PostgreSQL sudah terinstal."
    exit 1
fi

# Mapping tabel dan file CSV
declare -A TABLES
TABLES["01_Outbond_Roamer_Overal_Daily"]="01_Outbond_Roamer_Overal_Daily.csv"
TABLES["02_Outbond_Roamer_Country_Daily"]="02_Outbond_Roamer_Country_Daily.csv"
TABLES["03_Outbond_Roamer_Country_Operator_Daily"]="03_Outbond_Roamer_Country_Operator_Daily.csv"

CSV_DIR="C:\\NTI\\Final_Project"  # Gunakan path Windows

echo "🔄 Memulai proses import data..."

for TABLE_NAME in "${!TABLES[@]}"; do
    FILE_NAME="${TABLES[$TABLE_NAME]}"
    FILE_PATH="${CSV_DIR}\\${FILE_NAME}"  # Gunakan path Windows

    if [ ! -f "$(echo "$FILE_PATH" | sed 's/\\/\//g')" ]; then
        echo "❌ ERROR: File $FILE_PATH tidak ditemukan!"
        continue
    fi

    echo "🔄 Mengosongkan tabel: $TABLE_NAME..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "TRUNCATE TABLE \"$SCHEMA_NAME\".\"$TABLE_NAME\";"


    echo "📤 Mengimpor file $FILE_NAME ke tabel $TABLE_NAME..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "\COPY \"$SCHEMA_NAME\".\"$TABLE_NAME\" FROM '$FILE_PATH' WITH DELIMITER '|' CSV HEADER;"


    if [ $? -eq 0 ]; then
        echo "✅ Berhasil mengimpor $FILE_NAME ke $TABLE_NAME!"
    else
        echo "❌ Gagal mengimpor $FILE_NAME ke $TABLE_NAME! Cek error_log.txt untuk detail."
    fi
done

unset PGPASSWORD
echo "🎉 Semua proses import selesai!"
