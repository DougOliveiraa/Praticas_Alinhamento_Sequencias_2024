#!/bin/bash

# Script de Alinhamento com Bowtie
# Este script executa o alinhamento de sequências com Bowtie, criando um índice para o arquivo de referência
# e alinhando cada amostra individualmente.

# Parâmetros de entrada
REFERENCE="reference.fasta"
SAMPLES=("sample1.fasta" "sample2.fasta")  # Substitua pelos nomes dos arquivos das amostras

# Construção do índice de alinhamento com Bowtie
# O índice é necessário para o alinhamento eficiente das sequências da amostra contra a referência.
echo "Construindo o índice de referência com Bowtie..."
bowtie-build $REFERENCE reference_index
echo "Índice de referência criado."

# Alinhamento das sequências contra a referência de Wolbachia
for SAMPLE in "${SAMPLES[@]}"
do
  echo "Iniciando alinhamento para $SAMPLE..."

  # -f: Indica que o arquivo de entrada está no formato FASTA
  # -S: Saída no formato SAM
  # -a: Relatar todos os alinhamentos
  # -v 0: Permita 0 mismatches no alinhamento
  # -p 3: Use 3 threads para melhor performance
  # -t: Mostra uma mensagem de tempo detalhada no final
  OUTPUT="${SAMPLE%.fasta}.sam"
  LOG="${SAMPLE%.fasta}_bowtie.log"
  
  bowtie -f -S -a -v 0 -p 3 -t reference_index $SAMPLE > $OUTPUT 2> $LOG

  echo "Alinhamento concluído para $SAMPLE. Resultados salvos em $OUTPUT."
done

echo "Processo de alinhamento finalizado para todas as amostras."
