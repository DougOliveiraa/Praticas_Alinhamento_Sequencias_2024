#!/bin/bash

# Script de Limpeza de Dados
# Este script executa a avaliação de qualidade e limpeza de sequências de leitura. 

# Configurar nomes de arquivos
input_file="SRRXXXXXXX.fastq"  # Substitua pelo nome do seu arquivo de entrada

# Diretório de saída
output_dir="./output"
mkdir -p $output_dir

# 1. Avaliação de qualidade das leituras com FastQC
# FastQC é uma ferramenta útil para visualizar a qualidade das leituras de sequenciamento.
# Verifica a qualidade antes da limpeza para referência.
echo "Iniciando avaliação de qualidade com FastQC..."
fastqc $input_file -o $output_dir
echo "Avaliação de qualidade concluída."

# 2. Limpeza e corte de sequências de baixa qualidade com Trim Galore
# - --fastqc: executa o FastQC após a limpeza.
# - -q 25: trimma bases com qualidade inferior a 25.
# - --trim-n: remove bases N do início ou do final.
# - --max_n 0: falha se mais de zero "N" ocorrerem em qualquer leitura após o corte.
# - -j 1: usa 1 núcleo, ajustar conforme os recursos disponíveis.
# - --length 18: descarta leituras mais curtas que 18 nucleotídeos pós-corte.
# - --dont_gzip: não compacta as saídas, ajuste conforme a necessidade.
echo "Iniciando limpeza com Trim Galore..."
trim_galore --fastqc -q 25 --trim-n --max_n 0 -j 1 --length 18 --dont_gzip $input_file -o $output_dir
echo "Limpeza com Trim Galore concluída."

# Mensagem final
echo "Limpeza de dados concluída. Os arquivos de saída estão disponíveis em $output_dir"
