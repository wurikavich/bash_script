#!/bin/bash

readonly FILE_PATH="/path/to/file.ext"
readonly USERNAME="username"
readonly REMOTE_SERVERS=("server1" "server2" "server3")
readonly REMOTE_DIRECTORY="/path/to/remote/directory"
readonly EMAIL="mailbox@server.ru"

function send_message() {
  array_string=$(printf "%s\n" "${broken_servers[@]}")
  subject="Ошибка при отправки файла на серверы"
  echo "Проблемы с серверами: $array_string" | mail -s "$subject" -E "$EMAIL"
  if [ $? -eq 0 ]; then
    echo "Письмо со списком неисправных серверов было успешно сформированною и оправлено."
    exit 0
  else
    echo "Ошибка: Письмо не удалось отправить."
    exit 1
  fi
}

function send_files() {
  local broken_servers=()
  for server in "${REMOTE_SERVERS[@]}"; do
    local command="scp $FILE_PATH $USERNAME@$server:$REMOTE_DIRECTORY"
    $command
    if [ $? -ne 0 ]; then
      broken_servers+=("$server")
    fi
  done
  if [[ -n ${broken_servers[0]} ]]; then
    send_message
  fi
}

function check_environment() {
  if [[ -z $1 || -z $2 || -z $3 || -z $4 || -z $5 || -z $6 ]]; then
    echo "Ошибка: Одна из переменных не имеет значения или отсутствует."
    exit 1
  fi
}

function main() {
  day_week=$(date +%u)
  check_environment "$FILE_PATH" "$USERNAME" "$REMOTE_SERVERS" "$REMOTE_DIRECTORY" "$EMAIL" "$day_week"

  if [[ $day_week -ge 1 && $day_week -le 5 ]]; then
    send_files
  elif [[ $day_week -eq 6 || $day_week -eq 7 ]]; then
    exit 0
  else
    echo "Ошибка: Некорректное значения дня недели."
    exit 1
  fi
}

# Запуск скрипта
main
