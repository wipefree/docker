#!/bin/bash

# Копируем файлы в нужное место
#cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/ 2>/dev/null || true

# Создаем лог-файл
LOG_FILE="/tmp/copywar-debug.log"


# Функция для логирования
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Начало выполнения
log "=== СКРИПТ НАЧАЛ РАБОТУ ==="
log "Текущая директория: $(pwd)"
log "Пользователь: $(whoami)"
log "Переменные окружения:"
env >> $LOG_FILE

# Проверка существования исходной директории
log "Проверяем существование /boxfuse-sample-java-war-hello/target/"
if [ -d "/boxfuse-sample-java-war-hello/target" ]; then
    log "Директория /boxfuse-sample-java-war-hello/target/ существует"
    log "Содержимое /boxfuse-sample-java-war-hello/target/:"
    ls -la /boxfuse-sample-java-war-hello/target/ >> $LOG_FILE 2>&1
else
    log "ОШИБКА: Директория /boxfuse-sample-java-war-hello/target/ не существует!"
fi

# Проверка целевой директории
log "Проверяем существование /opt/apache-tomcat-9.0.34/webapps/"
if [ -d "/opt/apache-tomcat-9.0.34/webapps" ]; then
    log "Директория /opt/apache-tomcat-9.0.34/webapps/ существует"
else
    log "ОШИБКА: директорию /opt/apache-tomcat-9.0.34/webapps/ не существует"
    # Создание директории если нужно
    #mkdir -p /destination >> $LOG_FILE 2>&1
fi

# Копирование файлов
log "Начинаем копирование..."
cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/apache-tomcat-9.0.34/webapps/ >> $LOG_FILE 2>&1
CP_EXIT_CODE=$?
log "Код завершения cp: $CP_EXIT_CODE"

# Проверка результата
log "Проверяем результат копирования:"
ls -la /opt/apache-tomcat-9.0.34/webapps/ >> $LOG_FILE 2>&1

# Конец выполнения
log "=== СКРИПТ ЗАВЕРШИЛ РАБОТУ ==="

# Держим контейнер живым для проверки логов
log "Переходим в режим ожидания..."
#tail -f $LOG_FILE