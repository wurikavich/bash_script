# Тестовое задание на должность Python-разработчика.

## Задание:

Разработать скрипт c помощью bash. Который каждый час по рабочим дням загружает файл с 1-го сервера на другие.
Те серверы на которые не удалось загрузить, необходимо сохранить в список и оправить письмом на электронную почту.

## Настройка и запуск на удаленном сервере:

1. На удаленном сервере с которого предполагается отправка файла. Создайте новый bash-файл, название может быть любым:
   ```bash
   nano script.sh
   ```

2. В открывшемся редакторе код, добавьте [следующий код.](https://github.com/wurikavich/bash_script/blob/main/scritpt.sh):
    - Прописываем переменное окружения. Для этого в начале кода замените следующие значение на свои:
       ```bash
       FILE_PATH="Укажите путь до файла, который необходимо отправлять"
       USERNAME="Имя пользователя под которым вы заходите на сервер, на который предполагается рассылка"
       REMOTE_SERVERS="IP адреса серверов, на которые предполагается рассылка"
       REMOTE_DIRECTORY="Директория для хранения файла на сервере, на который предполагается рассылка"
       EMAIL="Электронный адрес для отправки отчета, в случае неисправности сервера"
       ```
    - Сохраните и закройте файл, нажав `Ctrl+X`, затем `Y`, затем `Enter`.

3. Запуск.
    - Дайте скрипту права на выполнение с помощью команды:
       ```bash
        chmod +x script.sh
       ```
    - Откройте файл cron для редактирования с помощью команды:
       ```bash
        crontab -e
       ```
    - Добавьте следующую строку в файл `cron`, чтобы скрипт запускался каждый час:
       ```bash
        0 * * * * /path/to/script.sh     # Замените /path/to/script.sh на путь к вашему файлу.
       ```
    - Сохраните и закройте файл `cron`, нажав `Ctrl+X`, затем `Y`, затем `Enter`.
   
    - ВНИМАНИЕ: Для отправки письмо используется команда `mail`.
   Важно проверить наличие пакета `mailutils` или `mailx` в дистрибутиве командами:
      ```bash
      Для Ubuntu и Debian:
         dpkg -s mailutils
         dpkg -s mailx
      Для CentOS и Fedora:
         rpm -q mailx
         rpm -q mailx
      
      Если команда выводит информацию о пакете, это означает, что пакет установлен в вашей системе.
      Если команда не выводит информацию о пакете или возвращает ошибку, то пакет не установлен.
      
      ```
    - В случае отсутствия эти пакетов, необходимо установить пакет `mailutils` командой:
      ```bash
       sudo apt-get install mailutils      # Для Ubuntu и Debian
       sudo yum install mailutils          # Для CentOS и Fedora
      ```
   
4. Остановка выполнения действий скрипта:
    - Выполните команду:
       ```bash
        ps aux | grep script.sh
        # Чтобы найти PID процесса скрипта. Найдите строку, содержащую ваш скрипт, и запишите PID.
       ```
    - Затем выполните команду:
       ```bash
        kill PID 
        # где PID - это идентификатор процесса вашего скрипта. Например, ваш PID равен 12345, выполните kill 12345
       ```

## Стек технологий

- Bash

## Разработчики

- [Александр Гетманов](https://github.com/wurikavich) - Backend