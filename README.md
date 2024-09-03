# Trainee_Krainet


## Описание

Этот репозиторий содержит Docker Compose конфигурацию для развертывания GitLab Community Edition (CE) и настройки CI/CD пайплайнов. Также включены инструкции по управлению Docker образами.

## Содержание

- [Предварительные требования](#предварительные-требования)
- [Запуск GitLab CE и Gitlab runner](#запуск-gitlab-ce-и-Gitlab-runner)
- [Настройка CI/CD](#настройка-cicd)
- [Управление Docker образами](#управление-docker-образами)
- [Примечания](#примечания)

## Предварительные требования

- Docker
- Docker Compose
- Docker-Desktop
- Git

Убедитесь, что Docker и Docker Compose установлены и работают на вашей машине.

## Запуск GitLab CE и Gitlab runner

1. Скопируйте docker-compose.yml
2. docker compose up -d
3. Перейдите по external_url 'http://localhost:8088'
4. Логин - root, пароль - gitlab_rails['initial_root_password'] = 'tsim0710tsim'
5. Create project -> create blank project | public
6. Настроить runner -> docker exec -it gitlab-runner gitlab-runner register \
  --non-interactive \
  --url 'http://localhost:8088' \
  --registration-token 'r3g1str4t10n' \
  --executor 'docker' \
  --docker-network-mode 'host' \
  --docker-image 'docker:dind'

7. Настроить(изменить) конфигурацию ruuner /etc/gitlab-runner/config.toml -> docker exec -it <CONTAINER ID> /bin/bash -> apt-get update && apt-get install -y nano
-> nano /etc/gitlab-runner/config.toml -> privileged = true | volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
8. Проверить runner в настройках проекта Settings/CICD/Runners


## Настройка CI/CD

