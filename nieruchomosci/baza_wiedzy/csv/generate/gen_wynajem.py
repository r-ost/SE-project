import csv
import random
def gen_oferty_wynajmu(max=100):
    with open('nieruchomosci/baza_wiedzy/csv/oferty_wynajmu.csv', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'ID','PropertyID','Status','Cena','KosztyDodatkowe','OpisKosztow','Kaucja','Negocjacja','MaxCena','MinCena','Wystawienie','Wygasniecie','MinStart','MaxStart','MinOkres','MaxOkres','Umowa','TypNajmu','Lokatorzy','OpisLokatorow','PreferowanyNajemca','Zwierzeta','PolitykaZwierzat','Opis','TypWlasciciela'
        ])
        for i in range(1, max+1):
            nid = f"n{i+100}"
            cena = random.randint(900, 9000)
            minokres = random.choice([3,6,12])
            maxokres = minokres + random.choice([6,12,24])
            writer.writerow([
                f"w{i}", nid, 'aktywna', cena, random.randint(100,800), 'media', random.randint(1000,5000),
                random.choice(['tak','nie']), cena+random.randint(100,500), cena-random.randint(100,500),
                f"2025-0{random.randint(1,9)}-01", f"2025-1{random.randint(0,2)}-01",
                f"2025-0{random.randint(1,9)}-01", f"2025-1{random.randint(0,2)}-01",
                minokres, maxokres, random.choice(['najem okazjonalny','zwykly']), random.choice(['calkowity','pokoj']),
                random.randint(0,5), random.choice(['brak','studenci','senior','rodzina']),
                random.choice(['student','senior','rodzina','singiel']), random.choice(['tak','nie']),
                random.choice(['możliwe małe zwierzęta','brak zwierząt','możliwe zwierzęta']),
                random.choice(['blisko uczelni','parter, winda','duże rodzinne mieszkanie','wysoki standard','ekonomiczne','luksusowe']),
                random.choice(['osoba_prywatna','firma'])
            ])