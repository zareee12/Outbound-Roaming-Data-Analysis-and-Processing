import pandas as pd

# Baca file Excel 1
df = pd.read_excel("01_Outbond_Roamer_Overal_Daily.xlsx", engine="openpyxl")

# Simpan ke CSV dengan delimiter |
df.to_csv("01_Outbond_Roamer_Overal_Daily.csv", sep="|", index=False)

print("Konversi selesai! File tersimpan sebagai 01_Outbond_Roamer_Overal_Daily.csv")

# Baca file Excel 2
df = pd.read_excel("02_Outbond_Roamer_Country_Daily.xlsx", engine="openpyxl")

# Simpan ke CSV dengan delimiter |
df.to_csv("02_Outbond_Roamer_Country_Daily.csv", sep="|", index=False)

print("Konversi selesai! File tersimpan sebagai 02_Outbond_Roamer_Country_Daily.csv")

# Baca file Excel 3
df = pd.read_excel("03_Outbond_Roamer_Country_Operator_Daily.xlsx", engine="openpyxl")

# Simpan ke CSV dengan delimiter |
df.to_csv("03_Outbond_Roamer_Country_Operator_Daily.csv", sep="|", index=False)

print("Konversi selesai! File tersimpan sebagai 03_Outbond_Roamer_Country_Operator_Daily.csv")
