* Изображение данных в виде карты *
* Загрузим необходимые пакеты *
ssc install spmap
ssc install shp2dta
* Разделим шейп-файл на два файла, один из которых это описание географических данных, а второй с координатами *
shp2dta using USA_States, database(usdb) coordinates(uscoord) genid(id)
* Открываем файл с описанием географических данных *
use usdb, clear
* Посмотрим из каких переменных состоит файл *
describe
 list id STATE_NAME in 1/5
* Мы хотим построить график численности населения по штатам, и у нас есть набор данных с именем stats.dta, содержащий данные о численности населения за 1990 год. *
* Объеденим файл stats.dta с созданным нами промежуточном файле  trans.dta, который содержит дополнительную необходимую нам информацию *
use stats
* Переменная scode является идентификатором *
merge 1:1 scode using trans
drop _merge
* Теперь мы должны объединить stats.dta с usdb.dta с карты. Это слияние основано на переменной id: *
merge 1:1 id using usdb
spmap pop1990 using uscoord if  STATE_NAME!="Alaska" &  STATE_NAME!="Hawaii", id(id) fcolor(Blues)
* Мы убрали Аляску и Гаваи из отображения на карте, так как по ним у нас не было данных в файле stats.dta *
