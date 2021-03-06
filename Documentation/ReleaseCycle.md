# Релизный цикл.

### Выпуск Release
    * Во вторник окончательно протестированная и исправленная rc-ветка до 17.00 вливается в **master** и в **develop**. Для этоого необходимо создать pull request rc-ветки в master и develop. **Важно!** В начале делается merge в **master**, а потом в **develop**.
    * В задачу дежурного входит проконтролировать чтобы команда влила все (bugfix/hotfix) в rc-ветку.
    * После того как rc-ветка влита в master, необходимо проверить следующее:
        - Успешное прохождения сборки(тесты и т.д)
        - Наличие выпущенного релиза с актуальным тэгом(external_version)
    * Далее необходимо влить **rc-ветку** в **develop**. Необходимо резрешить все конфликты в пользу ветки **develop**.

### Выпуск Hotfix
    * Создаем ветку **hotfix/<version>(например hotfix/1.0.1)** от **master**
    * Делаем все необходимые правки 
    * Поднимаем верисию приложения в ветке **hotfix/<version>**(можно воспользоваться скриптом set_version.command)
    * Создаем pull-request hotfix/<version> в master(после ревью вливаем)
    * Создаем ветку **hotfix/<version>-dev** от ветки **hotfix/<version>**
    * Подливаем ветку **develop** в **hotfix/<version>-dev**
    * Разрешаем конфликты и проверяем правильность версии(та, которая была до **hotfix**)
    * Создаем pull-request **hotfix/<version>** в develop(после ревью вливаем)

### Отрезание RC
    * В среду(2 неделя) в 16.00 от ветки **develop** создается ветка **rc/<version>**(например rc/1.1.1). До 16:00 команде необходимо подтвердить все pull requests и слить все свои изменения в ветку **develop**. Если по какой то причине остаются pull requests, то вливанием в develop занимается дежурный.
    * Далее необходимо проставить external_version в ветке **rc**, запустив скрипт set_version.command.
    * Далее необходимо создать ветку **bump-<version>(bump-1-1-1)** от ветки **develop** и поднять версию проекта запустив скрипт (start_next_release_version). Скрипт сбросит external_version на 0.0.0 и инкриментирует internal_version.
    * Далее создается pull request ветки **bump-<version>** в ветку **develop**.
    * До вторника(3 неделя) в rc-ветку вливаются все исправления(bugfix/hotfix), связанные с текущим релизом.
    * Сборки для тестирования rc-веток можно найти на странице связанной **Issue**.
    * После создания rc-ветки не допускается создавать pull requests c задачами текущего спринта. Это необходимо сделать до среды(2 неделя) до 16.00