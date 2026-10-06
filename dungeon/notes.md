# teleport
## animation system new notes
- znowu, zystem tworzac obiekt sam go update itd
- jedynie potem podajemy ereferencje do usuniecia
- dodatkowo: mov system tworzy pos itd, tak? wiec moze niech inaczej sie nazywa... entity czy cokolwiek. bo np. sparkles tez potrzebuja pos a nie beda ruszane...

## animation system...


CEL
- dodaję do systemu i działa
- jedynie potrzebuję referencji, aby usuanac

- uzywajac obecnego - po prostu automatyzowac
- system wykorzystuje .pos...

## notes...
Until wyświetlanie animacji w dowolnym miejscu. 
Tryb ciągły
Tryb jednorazowy

Miejsce teleport animacja sparkles
Przeniesienie
Animacja out smoke
Animacja in smoke
Implementacja przejścia przez ścianę
## current
- first: debug rectangle where teleport will be
- second: animation tool for sparkles animation
  - show them in place of teleport
  kfldkl

## current

- od ktorego tile szukac... dodatkowo rozpatrzyc jednoczesnie case stania pod sciana...
- moze: jesli juz sie na jakis poruszam, to jest to tile za ktorym zaczynamy szukac.
- w kazdym razie szukac niezaleznie od kierunku

## moving on a key

- first detect where player will be moved. show where (rectangle)

## generally
- press key. player is immediately moved to tile in a given direction.
- can be done even when moving (interrupt moving)
- hero stops on next obstacle(wall)
- extra effects
  - show sparklings in place where he can teleport
  - dust animation in previous place

## against wall
- if against wall, we will jump to other side (if able)

## adjustements
- 


# versions
## v3
- teleport
- fireball shot
- mana levels for bothkkkkkku

## v4
- first enemy

# MAIN DESIGN
- single screen
- enemies, traps, triggers
- collect all coins, or coins appear in random places and you have to collect given number
- every level is different layout, intense etc - goal is the same
- so action puzzle 

# ideas
- jumping. moves to the nereast wall. if against wall - jumps to next free tile


# notes
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

## extras
when appearing, also poof animation
(under main animation)

Trzęsienie się kamery przy jakimś wydarzeniu
jedna pula na strzelanie i teleport ktora powili sie odnawia. potion odnawaia.
