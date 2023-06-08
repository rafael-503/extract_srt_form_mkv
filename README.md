# Extrair legenda para SRT
Este script foi desenvolvido para extrair a legenda de um arquivo MKV e convertê-la para o formato SRT. Além disso, caso a legenda esteja no formato ASS, o script realiza a conversão para SRT.

## Pré-requisitos
O script foi projetado para ser executado em um ambiente Linux.
Os seguintes utilitários devem estar instalados no sistema:
- mkvinfo e mkvextract (fornecidos pelo pacote mkvtoolnix)
- O utilitário ffmpeg deve estar instalado no sistema.

## Uso
 $ ./legenda.sh arquivo [track=2] [format=srt]
  
Onde:

 - arquivo: é o nome do arquivo MKV do qual a legenda será extraída.
 - [track=2] (opcional): define a faixa de legenda a ser extraída. O valor padrão é 2, caso não seja especificado.
 - [format=srt] (opcional): define o formato de saída da legenda. O valor padrão é SRT, caso não seja especificado.
  
Certifique-se de fornecer o caminho completo para o arquivo MKV, se ele estiver em um diretório diferente do local onde o script está sendo executado.

## Exemplo
Suponha que você tenha um arquivo MKV chamado video.mkv e deseje extrair a segunda faixa de legenda para o formato SRT. Você pode executar o seguinte comando:

$ ./legenda.sh video.mkk

Isso extrairá a legenda do arquivo video.mkv e a salvará como video.srt.

Em caso de dúvidas ou problemas, sinta-se à vontade para entrar em contato.
