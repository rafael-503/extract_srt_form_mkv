#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <filename> [track=2] [format=srt]"
  exit 1
fi

filename="$1"
track="${2:-2}" # define a faixa de legenda como 2, se não especificado
format="${3:-srt}"  # define o formato como srt, se nenhum formato for especificado

if [[ ! -f "$filename" ]]; then
  echo "Arquivo '$filename' não encontrado."
  exit 1
fi

echo "Extraindo a legenda da faixa $track do arquivo '$filename'..."

# Verifica se a faixa de legenda é ASS
if mkvinfo "$filename" | grep -q "Codec ID: S_TEXT/ASS"; then
  echo "Arquivo de legenda é no formato ASS, convertendo para SRT..."
  mkvextract "$filename" tracks $track:"${filename%.*}.ass"
  ffmpeg -i "${filename%.*}.ass" "${filename%.*}.srt"
  rm "${filename%.*}.ass"
else
  mkvextract "$filename" tracks 2:"${filename%.*}.$format"
fi

if [[ ! -f "${filename%.*}.$format" ]]; then
  echo "Falha na extração da legenda."
  exit 1
fi

echo "Extração da legenda concluída!"

echo "Traduzindo a legenda para o idioma desejado..."

# Traduz a legenda usando o trans
input_file="${filename%.*}.$format"
output_file="${filename%.*}_translated.$format"
total_lines=$(wc -l < "$input_file")
translated_lines=0

while IFS= read -r line; do
  translated_line=$(trans -no-auto -b -e google -s en -t pt-br "$line")
  echo "$translated_line" >> "$output_file"

  translated_lines=$((translated_lines + 1))
  percentage=$((translated_lines * 100 / total_lines))
  echo -ne "Progresso: $percentage%\r"
done < "$input_file"

echo "Tradução da legenda concluída!"