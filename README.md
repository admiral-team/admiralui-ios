# AdmiralUI ![version](https://img.shields.io/badge/dynamic/json.svg?label=release&url=https://raw.githubusercontent.com/admiral-team/admiralui-ios/main/version.json&query=$.external_version)
Библиотека визуальных компонентов для `iOS`<br/></br>
<img width="1280" alt="Frame 336905" src="https://user-images.githubusercontent.com/100690555/170196915-069f01eb-f19a-443b-bdc6-4264bc6303fd.png">

## Что такое AdmiralUI?
`AdmiralUI` - это готовый набор элементов пользовательского интерфейса. Он
- Позволяет придерживаться единого визуального стиля и интерфейсных решений
- Ускоряет прототипирование
- Экономит время дизайнеров и разработчиков

## Демо приложение
Живым примером использования библиотеки `AdmiralUI` является наше демо-приложение, которое находится в деректории `ExampleiOS`. С ним вы сможете оценить все реализованные в библиотеке компоненты в разных состояниях, с возможностью переключения встроенных цветовых тем и созданию собственных.

## Общие сведения
* Основной язык разработки `Swift 5+`
* Поддерживаемы менеджеры зависимостей: `SPM (основной)`, `CocoaPods`, `Carthage`
* Минимальные поддерживаемые версии: `UIKit: iOS 11.0`, `SwiftUI: iOS 14.0`

## Настройка и подключение
Примеры подключения библиотеки, используя разные менеджеры зависимостей находятся в папке:
```
Examples/
```

### Swift Package Manager
#### Через UI Xcode:
```
File -> Swift Packages -> Add Package Dependency
```
#### Через Package.swift:
```
dependencies: [
    .package(url: “repo_path”, .upToNextMajor(from: “version”))
]
```  

### CocoaPods
1. Добавить в Podfile:
* Для UIKit:
```
pod 'AdmiralTheme', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralUIResources', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralUIKit', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
```
* Для SwiftUI:
```
pod 'AdmiralTheme', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralUIResources', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralSwiftUI', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
```
* Для SwiftUI и UIKit:
```
pod 'AdmiralTheme', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralUIResources', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralSwiftUI', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
pod 'AdmiralSwiftUI', :git => 'https://github.com/admiral-team/admiralui-ios.git', :branch => 'branch_name'
```
2. Выполнить в терминале команду:
```
pod install
```

### Carthage
1. Добавить в Cartfile:
```
git "repo_path" "branch_name"
```
2. Выполнить в терминале команду (обновления или сборки):
```
carthage update --platform iOS --use-xcframeworks
```
3. Вручную добавить фреймворк в проект Xcode:
```
Targets -> General -> Frameworks, Libraries and Embedded Content -> Carthage/Build/AdmiralUI.xcframework
```

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
