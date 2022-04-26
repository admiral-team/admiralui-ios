# AdmiralUI
Библиотека визуальных компонентов .<br />
Данная библиотека разработана для ускорения процесса разработки и  соблюдения единого дизайн линейки продуктов компании<br />

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
