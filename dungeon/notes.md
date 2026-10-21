# MANA NEW CONCEPT
## orbits
- potrzebny entity orbit_group
- bedzie mial wlasna pozycje itd i ogarnial 

# grafiki

- uprościć grafiki do stylu oryginału (mono colors)
- usunac stare, zeby nie kusiło

## fireball

## mana...

MOZE PO PROSTU PASEK NAD POSTACIĄ. kazdy piksel = 1 mana point

ALBO ZMIENIC SPOSOB MYSLENIA.. MOZE NIE FIOLKI.. MOZE MONOCOLOR POZIOM JAKIS CIEKAWY

jakis wielki pasek gdzies czy cos..
SPOJRZ NA GRE. POMYSL CO BY PASOWALO

moze wrocic do konceptow jakiegos geometrycznego pokazywania poziomu

# MANA LEVEL

## BUTELECZKA + NUMER

ale chyba w rogu, a nie nad graczem..


## poziom

- nad postacią buteleczka i numer

- pokazać ikonę i numerek?
- hmm.. skoro tylko poziom many będzie jedynym poziomem

OPCJE
- pasek nad postacią (dowolna ilość many, ale 3 kolory poziomu. zielony, żółty, czerwony)
- kolor gracza (np pierwsze zużycie zielony -> żółty -> czerwony -> czarny (brak)) = 4 strzały
  - kolor mógłby mrugać, albo utrzymać się chwilę. jeśli mruganie, to np bardzo częste
- pokazywanie ilości fiolek na chwilę
- pokazywanie dużej grafiki many z poziomem (taka bum po oczach)

## poziom życia

- czy będzie poziom zycia?
- wtedy byłby pokazywany w podobny sposob co mana
NIE. gra ma za krótkie levele. po prostu trzeba powtórzyć.

## BIEŻĄCE 

- najpeirw arbitralna ilosc. logika ze jak nie ma, to off
- fire nie działa, teleport nie działa (nie ma sparkles). dźwięk empty

## notatki
- ok, czy po prostu ogólnie, że zużywamy mana levl i tyle?
- mógłby to być prosty fire pokazywany nad nami. ile jeszcze zostalo.

- szerokosc sprite to 8... wiec mamy 8 many na kazdy czar
- strzał/teleport zużywa 1 i to widać na pasku

## wskaźnik..

aby testowac wskazniki, działają one pobierajac tylko poziom many. poradzą sobie same ze wskazaniem

moze jakis bardziej fancy wskaźnik... ale nadal aby było wiadomo, ile zostaje...

PROPOZYCJE
- RAMKA DOOKOŁA
- KOŁO ZAMYKAJĄCE SIĘ (co raz mniejsze)
- KOLOR czarodzieja


# versions
## v3
- [x] teleport
- [x] fireball shot
- [ ] mana levels for both
### MANA levels

- co jesli... jest tylko JEDEN strzał. i trzeba złapać fireball...
- trochę szalone. ale moznaby przetestowac ten koncept.
- drugą opcją jest, że złapanie fireball = death
ALBO jest to tylko opcja... i np jest bonus, jesli 

## v4
- first enemy

# MAIN DESIGN
- single screen
- enemies, traps, triggers
- collect all coins, or coins appear in random places and you have to collect given number
- every level is different layout, intense etc - goal is the same
- so action puzzle 

# ideas
## rember. simplicty!
our goal is to finish
so. one screen. and it will be
a puzzle to solve by actions

if we die - level restart

## mana levels

- jedna pula na strzelanie i teleport ktora powili sie odnawia. potion odnawaia.
- jeszcze lepiej: nie odnawia się, ale POTION odnowi!
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

## killing enemies
### tough
- są enemies w których trzeba walnać wiele razy
- są również niezniszczalni
- są enemies SUPER TWARDZI w których trzeba walnąć całą serię
