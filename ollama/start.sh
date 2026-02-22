#!/bin/sh
set -e

if [ -z "$OLLAMA_MODELS_LIST" ]; then
  echo " ERROR: La variable OLLAMA_MODELS_LIST no está definida."
  echo " Debes definirla en el archivo .env o en docker-compose.yml"
  exit 1
fi

echo "Iniciando Ollama..."
ollama serve &

sleep 5

echo "Modelos a descargar: $OLLAMA_MODELS_LIST"

for model in $OLLAMA_MODELS_LIST; do
  if ollama list | awk '{print $1}' | grep -qx "$model"; then
    echo "$model ya está descargado. Saltando pull."
  else
    echo "Descargando $model ..."
    ollama pull "$model"
  fi
done

wait
