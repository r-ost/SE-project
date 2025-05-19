import csv
import random


def gen_oferty_sprzedazy(max=100):
    with open('nieruchomosci/baza_wiedzy/csv/oferty_sprzedazy.csv', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'ID','PropertyID','Status','Cena','Negocjacja','CenaMax','CenaMin','DataWystawienia','DataWygasniecia','Platnosc'
        ])
        for i in range(1, max+1):
            nid = f"n{i}"
            cena = random.randint(150000, 2500000)
            writer.writerow([
                f"o{i}", nid, random.choice(['aktywna','nieaktywna']), cena, random.choice(['tak','nie']),
                cena+random.randint(10000,50000), cena-random.randint(10000,50000),
                f"2025-0{random.randint(1,9)}-01", f"2025-1{random.randint(0,2)}-01", random.choice(['gotowka','przelew','kredyt'])
            ])