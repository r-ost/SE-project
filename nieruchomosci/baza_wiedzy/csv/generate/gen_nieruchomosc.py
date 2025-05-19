import csv
import random

TYPY = ['mieszkanie', 'dom', 'apartament']
LOKALIZACJE = ['miasto', 'przedmiescia', 'centrum']
MIASTA = ['warszawa', 'krakow', 'poznan', 'wroclaw', 'gdansk', 'lodz', 'katowice', 'szczecin', 'bialystok', 'lublin']
REGIONY = ['mazowieckie', 'malopolskie', 'wielkopolskie', 'dolnoslaskie', 'pomorskie', 'lodzkie', 'slaskie', 'zachodniopomorskie', 'podlaskie', 'lubelskie']
STANDARDY = ['niski', 'sredni', 'wysoki', 'luksusowy']
KONSTRUKCJE = ['cegla', 'beton', 'zelbet']
ENERGIA = ['a', 'a+', 'a++', 'a+++', 'b', 'c']
OPISY = ['Idealne dla rodziny', 'Dla singla', 'Blisko uczelni', 'Luksusowe', 'Ekonomiczne', 'Przyjazne zwierzetom', 'Dla seniora', 'Nowoczesne', 'Do remontu', 'Wysoki standard']
def gen_nieruchomosci(max=200):  
    with open('nieruchomosci/baza_wiedzy/csv/nieruchomosci.csv', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'ID','Typ','Lokalizacja','Ulica','Miasto','Region','KodPocztowy','Kraj','Lat','Long','Odleglosc','Powierzchnia','Standard','Pokoje','Lazienki','Rok','Konstrukcja','Pietra','NrPietra','Winda','Parking','TypParking','Umeblowane','Ogrzewanie','Energia','Powodz','Stan','Opis','Dostepnosc','OstatniRemont','Utworzono','Zaktualizowano'
        ])
        for i in range(1, max+1):
            typ = random.choice(TYPY)
            lokalizacja = random.choice(LOKALIZACJE)
            miasto = random.choice(MIASTA)
            region = random.choice(REGIONY)
            standard = random.choice(STANDARDY)
            pokoje = random.randint(1, 7)
            lazienki = random.randint(1, 4)
            powierzchnia = random.randint(25, 250)
            odleglosc = round(random.uniform(0.5, 15.0), 1)
            stan = random.randint(1, 5)
            energia = random.choice(ENERGIA)
            opis = random.choice(OPISY)
            winda = random.choice(['tak', 'nie'])
            parking = random.choice(['tak', 'nie'])
            umeblowane = random.choice(['tak', 'nie'])
            pietra = random.randint(1, 10)
            nr_pietra = random.randint(0, pietra-1)
            rok = random.randint(1980, 2024)
            writer.writerow([
                f"n{i}", typ, lokalizacja, f"Ul. Testowa {i}", miasto, region, f"{random.randint(10,99)}-00{i%100}", 'polska',
                round(random.uniform(50.0, 54.0), 4), round(random.uniform(15.0, 22.0), 4), odleglosc, powierzchnia, standard,
                pokoje, lazienki, rok, random.choice(KONSTRUKCJE), pietra, nr_pietra, winda, parking, random.choice(['brak','garaz','podjazd','podziemny']),
                umeblowane, random.choice(['gazowe','miejskie','elektryczne']), energia, random.choice(['brak','niskie']), stan, opis,
                f"2024-07-{random.randint(1,28):02d}", f"2023-0{random.randint(1,9)}-01", f"2023-0{random.randint(1,9)}-01", f"2024-0{random.randint(1,9)}-01"
            ])