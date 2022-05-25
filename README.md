# AdmiralUI ![version](https://img.shields.io/badge/dynamic/json.svg?label=release&url=https://raw.githubusercontent.com/admiral-team/admiralui-ios/main/version.json&query=$.external_version)
Библиотека визуальных компонентов для `iOS`<br/></br>
<img width="1280" alt="Frame 336905" src="https://user-images.githubusercontent.com/100690555/170196915-069f01eb-f19a-443b-bdc6-4264bc6303fd.png">

## Что такое AdmiralUI?
`AdmiralUI` - это готовый набор элементов пользовательского интерфейса.

## Плюсы использования библиотеки:
- Позволяет придерживаться единого визуального стиля и интерфейсных решений
- Ускоряет прототипирование
- Экономит время дизайнеров и разработчиков

## Почему AdmiralUI?
- 💎 **Множество готовых компонентов** - 30+ компонентов на базе `UIKit/SwiftUI` от кнопок и текстовых полей до таймпикера и календаря.
- 🛠 **Кастомизируемость** - компоненты имеют множество настраиваемых свойств.
- 🎨 **Темизация** - поддержка разных цветовых палитр, возможность создания собственных и мгновенное переключение между ними.
- 🏗 **Поддержка** - релизы выходят раз в две недели, поддержка `SwiftUI` и `UIKit`.
- 📱 **Единый стиль на разных платформах** - есть библиотека под [Android](https://github.com/admiral-team/admiralui-android)

## Настройка и подключение
Детали подключения библиотеки в [wiki](https://github.com/admiral-team/admiralui-ios/wiki/Подключение-репозитория)

## Демо приложение
Живым примером использования библиотеки `AdmiralUI` является наше демо-приложение, которое находится в деректории `ExampleiOS`. С ним вы сможете оценить все реализованные в библиотеке компоненты в разных состояниях, с возможностью переключения встроенных цветовых тем и созданию собственных.

## Общие сведения
* Основной язык разработки `Swift 5+`
* Поддерживаемые менеджеры зависимостей: `SPM (основной)`, `CocoaPods`, `Carthage`
* Минимальные поддерживаемые версии: `UIKit: iOS 11.0`, `SwiftUI: iOS 14.0`

## Контрибьютерам
Мы рады любой помощи, и вы можете помочь нам с развитием этого проекта. Подробности в [wiki](https://github.com/admiral-team/admiralui-ios/wiki/Контрибьютерам)

## Команда проекта
<table>
  <tr>
    <td align="center"><a href="https://github.com/ton252"><img src="https://avatars.githubusercontent.com/u/13065321?v=4" width="80px;" alt="" /><br/><sub><b>Поляков Антон</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-ios/commits?author=ton252" title="Code">👑</a></td>
    <td align="center"><a href="https://github.com/KirBorisov96"><img src="https://avatars.githubusercontent.com/u/20974161?v=4" width="80px;" alt="" /><br/><sub><b>Борисов Кирилл</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-android/commits?author=KirBorisov96" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Almazovivan"><img src="https://avatars.githubusercontent.com/u/4298267?v=4" width="80px;" alt="" /><br /><sub><b>Алмазов Иван</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-android/commits?author=Almazovivan" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Andyatkov"><img src="https://avatars.githubusercontent.com/u/101252323?v=4" width="80px;" alt="" /><br /><sub><b>Андрей Дятков</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-android/commits?author=Andyatkov" title="Code">🛠</a></td>
  </tr>
</table>

### Структура проекта
Проект разделен на 4 модуля:
* `AdmiralUIResources` - все ресурсы (иконки / шрифты / цвета)
* `AdmiralTheme` - менеджер тем приложения
* `AdmrialUIKit (deprecated)`- библиотека компонентов на UIKit
* `AdmiralSwiftUI` - библиотека компонентов на SwiftUI

> Модули работают независимо друг от друга и их можно подключать отдельно. Например: если нужны только иконки и шрифты, следует подключить только `AdmiralUIResources`,  а если нужен только менеджер тем - `AdmiralTheme`
<br/>  

Так же существует приложение-витрина для демонстрации функционала:
* `ExampleiOS` - в данном приложении можно посмотреть примеры использования компонентов, как визуально, так и в коде
