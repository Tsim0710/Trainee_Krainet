# Trainee_Krainet


## Описание

Этот репозиторий содержит Docker Compose конфигурацию для развертывания gitlab-server и gitlab-runner, настройки CI/CD пайплайнов и Dockerfile 

## Инструкция

- [Предварительные требования](#предварительные-требования)
- [Запуск gitlab-ce и gitlab-runner](#запуск-gitlab-ce-и-Gitlab-runner)
- [Настройка CI/CD](#настройка-cicd)
- [Размещение файлов в проекте](#Размещение-файлов-в-проекте)
- [Сохранение и загрузка образа из Container Registry](#Сохранение-и-загрузка-образа-из-Container-Registry)

## Предварительные требования

- Docker
- Docker Compose
- Docker Desktop

Убедитесь, что Docker,Docker Compose и Docker Desktop установлены и работают на вашей машине.

## Запуск gitLab-ce и gitlab-runner

1. Скопируйте [docker-compose.yml](https://github.com/Tsim0710/Trainee_Krainet/blob/f29dd0f694e70654f0411eeb94a67ecca758fc7f/docker-compose.yml).
2. Выполните команду: `docker-compose up -d`
3. Перейдите по external_url `'http://localhost:8088'`
4. Логин - `root`, пароль - gitlab_rails['initial_root_password'] = `'tsim0710tsim'`.
5. Создайте проект в Gitlab.
6. Настройте runner:

```
docker exec -it gitlab-runner gitlab-runner register \
 --non-interactive \
 --url 'http://localhost:8088' \
 --registration-token 'r3g1str4t10n' \
 --executor 'docker' \
 --docker-network-mode 'host' \
 --docker-image 'docker:dind'
```
    
7. Измените конфигурацию `gitlab-runner`:

`docker exec -it container_id /bin/bash` 

`apt-get update && apt-get install -y nano`

`nano /etc/gitlab-runner/config.toml`

 Отредактируйте строки:

 `privileged = true`

 `volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]`


## Настройка CI/CD

1. Перейдите `Project` > `Build` > `Pipeline editor`.
2. Скопируйте [gitlab-ci.yml](https://github.com/Tsim0710/Trainee_Krainet/blob/92b003894d17f71001e367c757c187abe8cacc73/.gitlab-ci.yml).
3. Закоммитьте изменения.

## Размещение файлов в проекте
1. Скачайте файлы из архива: https://drive.google.com/file/d/1nFYofaF55wh4CeG1_hS4uRSjR-COE-SI/view?usp=sharing.

2. Добавьте в проект файл [Dockerfile](https://github.com/Tsim0710/Trainee_Krainet/blob/6b36acbf81c90521969f41782d7f45879778aae2/Dockerfile).



## Сохранение и загрузка образа из Container Registry

1. Сохраните образ в файл:
   
 `docker save -o <имя_файла>.tar localhost:5005/root/project_name`

2. Убедись, что файл создан:

 `ls -lh <имя_файла>.tar`

3. Загрузите архив:

 `docker load -i <имя_файла>.tar`
