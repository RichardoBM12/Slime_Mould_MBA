# <u>Estudiando el *Slime Mould*</u>

### Integrantes:

- ***Badillo Macías Ricardo***
- ***Valderrama Silva Alejandro***

## Introducción

El moho de fango, mejor conocido como “Slime Mould”  o “Physarum Polycephalum”, es un organismo unicelular (por lo tanto, no tienen ni cerebro ni neuronas) que da muestra de inteligencia, citando a la *School of Life Sciences*:

> Estos extraños organismos no son plantas, pueden ser móviles pero no son animales. Producen hongos como cuerpos fructíferos, pero no son hongos. Son inadaptados curiosos en nuestro mundo etiquetado y clasificado como -Slime moulds- amebas que producen esporas, una descripción simple que las resume perfectamente pero no explica ni remotamente lo extrañas que son en realidad.

Este organismo tiene varias etapas en su vida, descritas por el siguiente diagrama:

<p align="center">
  <img src="https://github.com/RichardoBM12/Slime_Mould_MBA/img/lifecycle.jpg?raw=true"/>
  
</p>

La etapa, en la que se encuentra el organismo, en la que está nuestro interés (porque es cuando observamos estas señales de inteligencia) es la etapa adulta del Slime. Mejor conocida como *Plasmodium*.

Gracias a varios experimentos y estudios realizados se ha puesto a prueba su "inteligencia" enfrentándolos a (resolver) algunos problemas, sobre todo respecto a gráficas.
Alguno de estos como el realizado por el grupo de Toshiyuki Nakagaki. En donde colocan al Slime en el centro de una configuración de hojuelas de avena, organizadas de tal manera que cada hojuela representa una ciudad cercana a Tokyo. En el desarrollo del experimento se puede observar como el Slime va construyendo una red (a través de sus tubos canalizadores de nutrientes) altamente similar al sistema ferroviario japonés. 

Como este hay otros experimentos que respaldan el poder de computo detrás de este organismo, como la solución de laberintos. Gracias a esta vasta cantidad de estudios prueban que esta capacidad de inteligencia está compuesta de varias "habilidades" sorprendentes. 

- Quimiotaxis: Se acercan o se alejan de diferentes sustancias químicas que detectan en su entorno. Es su principal herramienta para explorar su ambiente en busca de comida. 
- Phototaxis: Responden a la luz. Generalmente la evitan, pues la luz daña su DNA, pero son capaces de diferenciar colores. Cuando no la evitan es cuando están en su etapa de formar esporas, que es cuando están atraidos a la luz. 
- Memoria: Segregan un químico en zonas ya exploradas, lo que les permite saber en que zonas ya han estado. Parecido al mecanismo de feromonas utilizado por las colonias de hormigas.
- Durotaxis: Son capaces de "sentir" que tan dura o resistente es una superficies.
- *¿Aprendizaje?*

Todo esto resulta de especial interés no sólo por lo mencionado anteriormente o porque todo apunta a que es un sistema descentralizado; sino porque podría proporcionarnos una herramienta robusta para problemas de optimización, como búsquedas del camino más corto.

Para ello trataremos de realizar un modelo del Slime Mould que nos ayude a continuar estudiando sus propiedades de computo. Esto lo haremos mediante el paradigma de la Modelación Basada en Agente (MBA), pero ¿qué es la MBA?
La MBA es una metodología ampliamente utilizada en el estudio de sistemas complejos. Es adecuada para modelar fenómenos colectivos (muchos agentes interactuando) y descentralizados (sin un aparente líder o guía). La agregación de agentes permite observar dinámicas de autoorganización, de emergencia de patrones y comportamientos en una escala de organización superior.

Estos modelos se conforman de colecciones de agentes que interactúan con el entorno a través del tiempo. La MBA usa el enfoque **bottom-up**. Se considera a los agentes de manera individual con la flexibilidad de establecer características particulares y relaciones con otros agentes y el entorno. De manera global se genera nueva información que son caracterizadas en nuevas propiedades del sistema, las cuales no son deducidas de los objetos constituyentes del sistema.

Estos agentes son individuos autónomos computacionales con ciertas propiedades: variables de estado, valores y reglas de comportamiento. Por otro lado, la constante interacción de estos múltiples elementos distribuidos es lo que da pie al surgimiento de estructuras, patrones y propiedades novedosas y coherentes. Definiendo así, la emergencia del sistema; que se vislumbra en el surgimiento de atributos (estructuras o patrones) a nivel del sistema pero que no están codificados a nivel individual (agente).

### Un poco más de MBA

Enlistamos algunos modelos que creemos pueden mostrar bastante bien la esencia y utilidad de este paradigma.

- **SIR**: Acercamiento al modelo SIR, originalmente realizado con ecuaciones diferenciales que describe el proceso de contagio en una epidemia.

- **Boids**: Modela el comportamiento de mandas, basado en el comportamiento de parvadas.

  [^https://vimeo.com/58291553?fbclid=IwAR1C1qw5Jv7bCCR8nZy5QSIF5Ynx8-o3E6pdoWmCVb6QwYjL1JPz6oz-L6I]: 

  - **Boids-Ecosystem**: Modela el comportamiento de los boids en un ecosistema con alimento y depredadores.

- **Termitas apiladoras**: Modela una forma de "acomodar" distintas astillas de madera por termitas. 
  Posiblemente este sea el modelo, de los aquí presentados, que mejor muestre como a partir de reglas sencillas se puede describir un comportamiento global complejo. 

  1. Si la termita no esta cargando nada y se encuentra una astilla de madera, la recoge.
  2. Si está cargando una astilla de madera y se encuentras otra, suelta la astilla y continua su camino.

## Objetivo

Lo que buscamos hacer, con ayuda de la MBA, es crear un modelo que aproxime el comportamiento objetivo del *Slime Mould*. De esta manera nos será posible cuantificar qué tanto se aproxima el modelo y análisis realizado, al comportamiento real del Slime.

Además, con este proyecto buscamos mostrar un poco más del mundo que gira en torno a este paradigma, MBA. Para esto además del modelo que proponemos aquí incluiremos algunos otros modelos básicos que muestran lo que podemos hacer con la MBA.

## Hipótesis

A partir de incluir el reforzamiento de caminos por medio del concepto de quimiotaxis a un modelo básico de exploración (basado en movimientos brownianos) podremos aproximarnos al comportamiento de exploración que presenta el Slime Mould. 

[^El movimiento browniano es el movimiento aleatorio que se observa en las partículas que se hallan en un medio fluido]: 

## Diagrama de la metodología

<p align="center">
  <img src="https://github.com/a-valderrama/Genomica/blob/master/GenomicaComputacional/proyecto_final/img/Metodologia.png?raw=true"/>
</p>

### Resultado del modelo hasta ahora...

Movimiento de exploración sin incluir la atracción de alimento.

<p align="center">
  <img src="https://github.com/a-valderrama/Genomica/blob/master/GenomicaComputacional/proyecto_final/img/DLA-inverso-v1.jpeg?raw=true"/>
</p>
