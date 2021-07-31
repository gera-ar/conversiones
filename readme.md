# Conversiones
Script creado por Gerardo Késsler. [Reaper y otras yerbas](mailTo:ReaperYOtrasYerbas@gmail.com)  
La idea de este script es realizar conversiones rápidamente con solo enfocar el elemento a convertir, sin interfaces gráficas y con solo un par de atajos de teclado.  

## Comandos del script:

* f4; Convierte el archivo con el foco actual.
* shift + f4; Convierte todos los archivos que se encuentran en la carpeta actual, incluyendo las subcarpetas.
* shift + f1; lista los comandos del script y permite cambiarlos.
* alt + control + s; suspende y reanuda los atajos del script.
* alt + control + e; Cierra el script.

Pulsando aplicaciones sobre el ícono de la bandeja de sistemas, se puede modificar la calidad del audio resultante a través del bitrate. El valor por defecto es 128 kbps.

## ¿Como funciona?
Cuando estamos enfocados sobre un archivo de audio, video, o documento, al presionar f4 se activa un menú contextual donde podremos seleccionar el formato a convertir.  
Ingresamos al submenú del tipo de archivo que vamos a convertir y pulsamos intro sobre el formato de salida, lo que iniciará el proceso. Al finalizar se realizará un sonido que indica la finalización de la conversión.  
En el caso de que el formato deseado no se encuentre en la lista, la última opción de cada apartado es el ítem otros.  
Al pulsar en esta opción se activa un cuadro en el que deberemos escribir el formato de salida sin el punto, por ejemplo "opus, sin comillas, y pulsar intro, lo que iniciará la conversión.  
En el caso de querer convertir todos los archivos de una carpeta, pulsamos el atajo correspondiente situados dentro de la misma. Al pulsarlo se activa una pequeña ventana gui con una lista de formatos de salida. Seleccionamos el correcto y pulsamos en la opción iniciar conversión, y al finalizar se reproducirá un sonido que indica la finalización del proceso.  
nota:  
En el caso de las conversiones entre documentos es conveniente copiar el archivo a convertir al portapapeles antes de presionar el atajo para iniciar el proceso.

## Algunas aclaraciones:
El ffmpeg permite convertir entre una extensa lista de formatos. Entre video y video, entre video y audio, y entre audio y audio.
para una lista detallada de los formatos soportados, haga click 
[aquí](https://es.wikipedia.org/wiki/FFmpeg)  
Para las conversiones entre documentos se utiliza el programa pandoc. Para una lista detallada de formatos soportados, pulse el siguiente
[link](https://es.wikipedia.org/wiki/Pandoc)  

### Error en las librerías:
Puede que en algunos sistemas operativos no funcionen correctamente ffmpeg o pandoc por la ausencia de siertas librerías importantes para el sistema.  
En tal caso puede descargar un instalador de las librerías necesarias desde el siguiente
[enlace directo](https://www.mediafire.com/file/0a6bpgnr9rhf4kp/MPVCI_2.5_setup.rar/file)  
lo que debería solucionar el problema.

