#!/bin/bash

if [ -z "$1" ]
then
  echo "Usage: $0 <filename> [track=2] [format=srt]"
  exit 1
fi

filename="$1"
track="${2:-2}" # define a faixa de legenda como 2, se não especificado
format="${3:-srt}"  # define o formato como srt, se nenhum formato for especificado

if [[ ! -f "$filename" ]]
then
  echo "Arquivo '$filename' não encontrado."
  exit 1
fi

echo "Extraindo a legenda da faixa $track do arquivo '$filename'..."

# Verifica se a faixa de legenda é ASS
if mkvinfo "$filename" | grep -q "Codec ID: S_TEXT/ASS"; then
  echo "Arquivo de legenda é no formato ASS, convertendo para SRT..."
  mkvextract "$filename" tracks $track:"${filename%.*}.ass"
  ass2srt "${filename%.*}.ass" -o "${filename%.*}.srt"
  rm "${filename%.*}.ass"
else
  mkvextract "$filename" tracks 2:"${filename%.*}.$format"
fi

if [[ ! -f "${filename%.*}.$format" ]]
then
  echo "Falha na extração da legenda."
  exit 1
fi

echo "Extração da legenda concluída!"