#!/bin/bash

# Перевірка прав root
if [[ $EUID -ne 0 ]]; then
   echo "Сценарій повинен виконуватись із правами root. Використовуйте sudo."
   exit 1
fi

# Визначення імені лог-файлу
OUTPUT_FILE="Output.log"

# Початковий запис у лог
echo "=== Збір мережевої інформації ===" > $OUTPUT_FILE
echo "Час запуску: $(date)" >> $OUTPUT_FILE
echo "----------------------------------" >> $OUTPUT_FILE

# Виконання nmap-сканування
echo "[1] Сканування локальної мережі (nmap):" >> $OUTPUT_FILE
nmap -sP 192.168.1.3/24 >> $OUTPUT_FILE 2>&1
echo "----------------------------------" >> $OUTPUT_FILE

# Виконання tcpdump для збору мережевого трафіку
echo "[2] Захоплення трафіку за допомогою tcpdump (10 секунд):" >> $OUTPUT_FILE
timeout 10 tcpdump -i any -c 100 >> $OUTPUT_FILE 2>&1
echo "----------------------------------" >> $OUTPUT_FILE

# Підсумок
echo "Завершено. Дані записані в файл $OUTPUT_FILE."
