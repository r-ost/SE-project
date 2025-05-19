import gen_wynajem
import gen_sprzedaz
import gen_nieruchomosc

max = int(200)

gen_nieruchomosc.gen_nieruchomosci(max)
gen_wynajem.gen_oferty_wynajmu(int(max/2)) 
gen_sprzedaz.gen_oferty_sprzedazy(int(max/2))