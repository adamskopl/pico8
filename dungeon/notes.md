# GITHUB PRIVATE

- no, commitujemy podczas pracy...
- schowac jak najszybciej. kod opublikuje się jako jeden commit potem
ALBO LEPIEJ - nie robic historii zmian. po prostu jeden commit caly czas update i push

---
# fireball wizard death
# Death: zostaje sam kapelusz 

Wizard się rozsypuje. Zostaje kapelusz
jednoczesnie opracowac wspolna animacje death dla wszystkich (rozsypujące się pixele w kolorze entity)
moze niech rozsypują się w kierunku siły. ale - jest to rozsypanie jakby po podłodze. czyli pixele kładą się i po kilku sekudnach znikają. też zależnie od siły zniszczenia


# FIRST LEVELS
## do implementacji...

- przegrana - dopadł nas przeciwnik (jak giniemy? jak wygląda restart level)
  - zaczyna mrygac press any to try again
- zebranie finalowego powoduje poof jak teleport (wizard teleportuje sie poza level)

## pierwsze levele mają uczyć

- każdy level uczy czegoś innego. najlepiej, aby uczył 1 rzeczy. i tą rzecz TRZEBA wykonać

## first level...

### level start
Po wizard pojawia się pop in. Aby zgrywało się z przejściami level 
### WIN

- eee... pojawia się skrzynia do ktorej wpadają monety? ekran moglby wygasnac (znika level, zostaje tylko tlo) tak jak w przypadku przegranej
#### aniamcja win
Tam gdzie jest wizard - obok pojawia się skrzynia 
Pop standardową animacja

Do skrzyni wpada tyle monet ile zebraliśmy (pop in, wpada, dźwięk collect, pop in, wpada.. szybko wszystkie). Skrzynia podskakuje dostając monety.
Skrzynia znika
Wizard znika

### wizard appear
- na start level wizard pojawia sie jak moneta. wiec poof
### LOOSE

- kurde, cos z tymi priv vars zmienic... ciezko.
### DUZA ZMIANA O MONETY


### ...

- zebrac tylko monety
- pusty level, monety rozrzucone. brak many na start!
- zbierzemy - poof. wizard jak teleport i znika. 2s i pojawia sie next level

## second level 0.1
- pokazanie ze nie zebranie coin powoduje przegraną. jest level z odnogami, tam są monety.
- jesli gracz sie nie obija, to zbiera wszystko z palcem w nosie
- ale wystarczy ze tylko troche sie spozni - game over
- wiec to ma nauczyc ruszac sie i zbierac monety i pokazac konsekwencję
## second level

- grunt. mozna przeskoczyc albo rozwalic (mamy 1 manę)
  - nie. 1 level gdzie musimy przeskoczyc. 2 level gdzie musimy rozwalic (przeskok np pozbawi nas many ktorej nie zbierzemy, a fireball pozwoli)
- grunt ma stac i czekac, ale nadal ma logikę, by ruszyć w naszym kierunku. stoi w korytarzu. simple 
- zawsze zaczynamy z 0 mana - trzeba napic sie z fiolki (wiec bedzie jednak fiolka... dodaj ją jak jest. albo zmodyfikuj do płaskiej
  - jedna fiolka = 1 mana
  - super fiolka = 3 mana

# -> MAIN DESIGN
- single screen
- enemies, traps, triggers
- collect all coins, or coins appear in random places and you have to collect given number
- every level is different layout, intense etc - goal is the same
- so action puzzle 

## coins

- trzeba zebrac wszystkie.
- pojawiaja sie warunkowo (trigger)
- niewiadomo ile jest do zebrania. czasem nawet nie ma kolejnosci.
- nawet ENEMIES MOGĄ JE GUBIĆ! tylko niektórzy mają. ale chyba byłoby dobrze widać, którzy mają... a moze czasem widać, czasem nie.
- kiedy zbierzemy wszystkie jest win. ale. co z win? raczej po prostu instant koniec. bedzie tez ciekawa niespodzianka 'czy to ostatnia moneta'

# -> IDEAS
## rember. simplicty!
our goal is to finish
so. one screen. and it will be
a puzzle to solve by actions

if we die - level restart

## about level
one screen per level
monsters are spawning constantly
when objective done, stair show
at random tile (but far away)

also bonuses are showing up
at random?

coins to collect also could show
randomly. so we have to collect

let's start with that

## enemies
- taki ktorego nie da sie zniszczyc, jedynie zatrzymac
## killing enemies
### tough
- są enemies w których trzeba walnać wiele razy
- są również niezniszczalni
- są enemies SUPER TWARDZI w których trzeba walnąć całą serię
## doors!
- doors can be opened (or destroyed?). it will open also paths for enemies.
## klucz

- trzeba zebrac, aby otworzyc drzwi. moze po prostu zbieram i drzwi sie otwieraja i tyle
## pomysł... kapelusz jako item...
- co moglby oznaczac zebrany kapelusz

# -> EXTRAS
## Niech level planszaa animację zapętloną związaną z danym level 

Rączej bardziej jako ozdoba niż instrukcja.
Proste, nawet powtarzające się.. ale jakiś dodatek

Np level 1 wiz przechodzi przez środek, zbiera monetę i znika
