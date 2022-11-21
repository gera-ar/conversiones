# Conversiones

Script creado por Gerardo Késsler. [ReaperYOtrasYerbas@gmail.com](mailTo:ReaperYOtrasYerbas@gmail.com)  
La idea de este script es realizar conversiones rápidamente con solo enfocar el elemento a convertir, sin interfaces gráficas y con solo un par de atajos de teclado.  

## Comandos del script:

* shift + f1; activa una ventana con la lista de comandos y opciones para modificar los atajos.
* control + f4; Convierte el archivo con el foco actual.
* shift + f4; Convierte todos los archivos que se encuentran en la carpeta actual, incluyendo las subcarpetas.
* control + shift + f4; suspende y reanuda los atajos del script.
* control + barra espaciadora; reproduce una vista previa del archivo con el foco
* control + shift + q; Cierra el script.

Pulsando aplicaciones sobre el ícono de la bandeja de sistemas Conversiones, se puede modificar la calidad del audio resultante a través del bitrate. El valor por defecto es 128 kbps.

## Vista previa

Al pulsar el atajo asignado para la vista previa se abre una pequeña ventana en la que podremos utilizar los siguientes comandos:

* Barra espaciadora; pausar y reanudar la reproducción
*9 (alfanumérico); disminuir el volúmen de la reproducción
* 0 (alfanumérico); aumentar el volúmen de la reproducción
*m; conmutar el silencio
* flechas izquierda y derecha; retroceder y adelantar la reproducción 10 segundos
* flechas arriba y abajo; adelantar y retroceder la reproducción un minuto
* q o escape; cierra la vista previa

## ¿Como funciona?

Cuando estamos enfocados sobre un archivo de audio, video, o documento, al presionar f4 se activa un menú contextual donde podremos seleccionar el formato a convertir.  
Ingresamos al submenú del tipo de archivo que vamos a convertir y pulsamos intro sobre el formato de salida, lo que iniciará el proceso. Al finalizar se realizará un sonido que indica la finalización de la conversión.  
En el caso de que el formato deseado no se encuentre en la lista, la última opción de cada apartado es el ítem otros.  
Al pulsar en esta opción se activa un cuadro en el que deberemos escribir el formato de salida sin el punto, por ejemplo "opus, sin comillas. Al  pulsar intro se iniciará la conversión. El archivo de salida se crea en la misma carpeta donde se hubica el original, con el mismo nombre y su nueva extensión.  
Para convertir todos los archivos de una carpeta, pulsamos el atajo correspondiente situados dentro de la misma. Al pulsarlo se activa una pequeña ventana gui con una lista de formatos de salida. Seleccionamos el correcto y pulsamos en el botón iniciar conversión, y al finalizar se reproducirá un sonido que indica la finalización del proceso. Los archivos resultantes se guardan en una nueva carpeta llamada convertidos dentro del directorio actual.  

## Formatos soportados:

El ffmpeg permite convertir entre una extensa lista de formatos. Entre video y video, entre video y audio, y entre audio y audio.
para una lista detallada de los formatos soportados, haga click 
[aquí](https://es.wikipedia.org/wiki/FFmpeg)  
Para las conversiones entre documentos se utiliza el programa pandoc. Para una lista detallada de formatos soportados, pulse el siguiente
[link de wikipedia](https://es.wikipedia.org/wiki/Pandoc)  

### Error en las librerías:

Puede que en algunos sistemas operativos no funcionen correctamente FFMPEG o pandoc, por la ausencia de siertas librerías importantes para el sistema.  
En tal caso puede descargar un instalador de las librerías necesarias desde el siguiente
[enlace directo](https://www.mediafire.com/file/0a6bpgnr9rhf4kp/MPVCI_2.5_setup.rar/file)  
 Solo hay que instalar el archivo, lo que debería solucionar el problema.
La contraseña es "reaper", sin comillas.

