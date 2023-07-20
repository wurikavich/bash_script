#!/bin/bash

readonly FILE_PATH="/path/to/file.ext"
readonly USERNAME="username"
readonly REMOTE_SERSERS=("server1" "server2" "server3")
readonly REMOTE_DIRECTORY="/path/to/remote/directory"
readonly EMAIL="mailbox@server.ru"

day_week=$(date +%u)

function send_message() {
  array_string=$(printf "%s\n" "${broken_servers[@]}")
  subject="Неудачная отправка файла на сервис"
  message="Проблемы с сервисами:\n$array_string"
  mail -s "$subject" $EMAIL <<<"$message"
}

function send_files() {
  local -n broken_servers=()
  for server in "${REMOTE_SERSERS[@]}"; do
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

if [[ $day_week -ge 1 && $day_week -le 5 ]]; then
  send_files
elif [[ $day_week -eq 6 || $day_week -eq 7 ]]; then
  exit 0
else
  echo "Ошибка при обработке дня недели."
  exit 1
fi
