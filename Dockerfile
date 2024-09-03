# Используем официальный образ OpenJDK в качестве базового
FROM openjdk:latest

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем содержимое текущей директории в контейнер
COPY . /app

RUN chmod +x ./mvnw
# Запускаем Maven для сборки приложения (предполагается, что используется Maven Wrapper)
RUN ./mvnw clean install -DskipTests


# Открываем порт 8080 для доступа к приложению
EXPOSE 8080

# Команда для запуска приложения (замените 'your-app.jar' на имя вашего jar-файла)
CMD ["java", "-jar", "target/your-app.jar"]