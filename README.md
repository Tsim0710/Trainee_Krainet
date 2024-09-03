# Trainee_Krainet


## Описание

Этот репозиторий содержит Docker Compose конфигурацию для развертывания GitLab Community Edition (CE), настройки CI/CD пайплайнов и Dockerfile 

## Инструкция

- [Предварительные требования](#предварительные-требования)
- [Запуск GitLab CE и Gitlab runner](#запуск-gitlab-ce-и-Gitlab-runner)
- [Настройка CI/CD](#настройка-cicd)
- [Разместите в проекте файлы из архива](#Разместите-в-проекте-файлы-из-архива)
- [Сохранить image из container и сохранить image в tar](#Сохранить-image-из-container-и-сохранить-image-в-tar)

## Предварительные требования

- Docker
- Docker Compose
- Docker-Desktop

Убедитесь, что Docker и Docker Compose установлены и работают на вашей машине.

## Запуск GitLab CE и Gitlab runner

1. Скопируйте docker-compose.yml (Из репозитория)
2. docker compose up -d
3. Перейдите по external_url 'http://localhost:8088'
4. Логин - root, пароль - gitlab_rails['initial_root_password'] = 'tsim0710tsim'
5. Create project -> create blank project | public
6. Настроить runner одной командой:


 docker exec -it gitlab-runner gitlab-runner register \
  --non-interactive \
  --url 'http://localhost:8088' \
  --registration-token 'r3g1str4t10n' \
  --executor 'docker' \
  --docker-network-mode 'host' \
  --docker-image 'docker:dind'

7. Настроить(изменить) конфигурацию gitlab-runner:

docker exec -it container_id /bin/bash 

apt-get update && apt-get install -y nano

nano /etc/gitlab-runner/config.toml

Измените строки:
 privileged = true
 volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]


## Настройка CI/CD

1. Перейдите Build/Pipline editor
2. Замените содержимым gitlab-ci.yml (Из репозитория)

## Разместите в проекте файлы из архива
https://drive.google.com/file/d/1nFYofaF55wh4CeG1_hS4uRSjR-COE-SI/view?usp=sharing

Добавить Dockerfile(Из репозитория) и дождаться выполнения пайплайна. 

## Сохранить image из Container registry в tar и загрузить архив

docker save -o <имя_файла>.tar localhost:5005/root/project_name

Убедись, что файл создан:
ls -lh <имя_файла>.tar

Загрузите архив:
docker load -i <имя_файла>.tar
