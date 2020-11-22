# Análisis de las emisiones de CO2 a nivel mundial

El objetivo del trabajo va a ser estudiar a nivel mundial y europeo, la evolución de una serie de variables relacionadas con el medio ambiente y la energía, centrando sobretodo el análisis en las emisiones de gases de CO2 responsables del cambio climático.

Concretando más, el trabajo va a consistir en tres partes diferenciadas, aunque relacionadas:

- En primer lugar un análisis de la varianza referido a la relación entre el PIB per cápita y el precio de los combustibles fósiles.

- Un análisis de componentes principales, en el cual vamos a intentar mostrar la interrelación que existe entre variables de crecimiento, consumo, industria, con variables contaminantes.

- Un análisis cluster, en el cual se va a estudiar, para el caso de la UE, la evolución de la producción de renovables y emisiones de CO2 desde 1990 hasta 2016, realizando agrupaciones según como avancen estas dos variables.

Se pretende dar una visión general de lo importante que es tener en cuenta las emisiones de gases nocivos, y como la utilización de energías renovables es crucial para luchar contra el cambio climático (esto lo veremos muy bien en el análisis clúster).


## Principales descubrimientos a través de los datos

### Reducción de la dimensionalidad con PCA
Tenemos, que a través de un análisis de PCA podemos resumir un conjunto de variables relacionadas con el crecimiento económico y la contaminación, en dos componentes principales, estos dos componentes son:

- PC1 va a venir referido a **“Factores económicos ligados a la contaminación”.** Aquí se resumen las variables PIB, Gasto en Consumo Final y CO2 Liquido.
- PC2 va a venir referido a **“Contaminación provocada por la industria”.** Aquí se reúnen dos variables, el VAB de la industria y Contaminación del Aire.

![PCA](https://user-images.githubusercontent.com/54073772/98850120-91637800-2454-11eb-950d-f2333bede3fc.PNG)

Poder resumir varias variables a través de componentes principales nos permite una mejor interpretación de los datos, visualización y comunicación.

### Relación entre CO2 y Renovables. Clusterización

¿Cómo ha sido la evolución de las emisiones de CO2 en los últimos años? **Al incrementar el uso de las energías renovables, ¿Cómo se ha reducido la emisión?** En el siguiente gráfico podemos observar cómo han evolucionado las variables CO2 y Renovables y que relación tienen ambas.

![Correlation](https://user-images.githubusercontent.com/54073772/98852065-69294880-2457-11eb-82c4-84a73eeeaecf.PNG)

El gráfico sorprende en el sentido que no vemos una disminución notoria de las emisiones de CO2 hasta el año 2009, en los años noventa existían menos energías renovables en funcionamiento, aún así la contaminación es mayor en el periodo 2003-2008 aunque la producción de renovables era mayor. Este gráfico nos intuye la existencia de 3 grupos o más bien, 3 periodos significativos en la relación entre CO2 y producción de renovables. 

A través de la clusterización, usando k-means asignamos cada observación a cada periodo distintivo, llevándonos al siguiente resultado:

![Cluster](https://user-images.githubusercontent.com/54073772/98852012-5747a580-2457-11eb-8fe5-4b3f75b3f9e4.PNG)
