
# Rozpoznání řeči a následné odhadnutí začátku a konce
#### Verze Matlabu: 2023b

### Bonusová úloha č. 2
- [x] bod za splnění
- [x] bod za výhru

## Popis
*Nejprve se odstraní offset, tedy průběh bude mít střed v 0. Pak se signál rozdělí na sekce, s tím že sekce se z 90% překrývají a vypočítá se jejich průměrná hodnota jak nad, tak i pod osou x. Tímto si neuberu moc dat a zároveň odstraním prudké velmi krátké změny (např. lupnutí). Vypočítám nejvyšší výkmit od osy x (budu nazývat NV od teď). Poté všechny zprůměrované hodnoty, které jsou nižší než 8% NV se dají na 0. Tím se zbavím šumu. Také dám 0 všude tam, kde se průměrná hodnota nad osou a pod osou výrazně liší (bez znaménka). To totiž znamená, že to není hlas člověka. Poté již pouze vezmu první sekci kde není 0 a poslední sekci kde není nula. Z těch si vypočítám čas. Posledním krokem je přičtení 60ms k určenému konci zvuku, protože je zde doznívání hlasu, které nechceme useknout.*

![Příklad](https://raw.githubusercontent.com/SmejkyJ/matlab-image-recognition/main/example_1.png)

## Funkce
```matlab
splitToSections(filePath)
```
- filePath - cesta k 2 sekundovému 16kHz audio souboru
- vrací strukturu s časem začátku a konce
  - first - čas začátku
  - last - čas konce
___
