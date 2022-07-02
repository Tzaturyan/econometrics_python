* Оценивание линейных регрессионных моделей *
* Задача*
* Открыть файл  mrw.dta, создать логарифмы переменных, оценить модель Солоу отдельно для экспортеров нефти и не экспортеров, определить значимы ли модели с помощью R2, протестировать линейное ограничение для нашей модели, оценить расширенную модель Солоу, построить безусловную модель конвергенции *
use mrw.dta 
gen lngdp85=ln(gdp85) gen lngdp60=ln(gdp60) gen lngdprow=ln(lngdprow) gen lnngdelta=ln(popgrow/100+0/05) gen lninv = ln(inv/100) gen lnschool=ln(school) *
reg lngdp85 lnngdelta lninv if nonoil==1 *
reg lngdp85 lnngdelta lninv if intermed==1 *
reg lngdp85 lnngdelta lninv if oecd==1 *
net search outreg2
* Протестрируем линейную гипотезу о равенстве с противоположным знаком коэффициентов в базовой модели Солоу для стран не экспортеров нефти *
test lnngdelta + lninv = 0 *
* Результаты показали что мы не можем отвергнуть нулевую гипотезу *
* Оценим модель Солоу с ограничениями *
constraint 1 lnngdelta = -lninv *
* Для оценивания моделей с ограничениями на параметры используется команда cnsreg *
cnsreg lngdp85 lnngdelta lninv if nonoil==1, constraints(1) cnsreg lngdp85 lnngdelta lninv if intermed==1, constraints(1) cnsreg lngdp85 lnngdelta lninv if oecd==1, constraints(1) *
* Построим диаграмму рассеивания для переменных логарифмов темпов роста и ВВП в 1960г. для всех наблюдаемых в выборке стран *
scatter lngdp85_lngdp60 lngdp60 *
* Видим что никакой ярко выраженной отрицаьельной зависимости между логарифмами темпа роста и темпом роста ВВП в 1960г. не наблюдается, следовательно мы не можем говорить о безусловной бета-конвергенции в данном случае *
