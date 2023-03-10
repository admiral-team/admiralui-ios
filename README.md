# AdmiralUI ![version](https://img.shields.io/badge/dynamic/json.svg?label=release&url=https://raw.githubusercontent.com/admiral-team/admiralui-ios/main/version.json&query=$.external_version)
The visual component library for `iOS`<br/></br>
<p align="center">
<img src="/Documentation/ios.gif?raw=true" align="middle">
</p>

## Setup and connection
Library connection details in [wiki](https://github.com/admiral-team/admiralui-ios/wiki)

## What is AdmiralUI?
`AdmiralUI` - is a ready-made set of user interface elements. 

## Components overview: 

To learn more about the status of the `AdmiralUI` design system components and their names in the code, please follow this [<strong>link</strong>](https://github.com/admiral-team/admiralui-ios/blob/develop/Documentation/info/documentation.pdf)

## Benefits of using a library:
- Allows you to follow to a single visual style and interface solutions
- Speeds up prototyping
- Saves time for designers and developers

## Why AdmiralUI?
- 💎 **Lots of ready made components** - 30+ `UIKit/SwiftUI` based components from buttons and text fields to timepicker and calendar..
- 🛠 **Customizability** - components have many custom properties.
- 🎨 **Themization** - support for different color palettes, the ability to create your own and instantly switch between them.
- 🏗 **Support** - releases come out every two weeks, support `SwiftUI` and `UIKit`.
- 📱 **Consistent style across platforms** - availible library for [Android](https://github.com/admiral-team/admiralui-android)

## Demo app
A live example of using the `AdmiralUI` library is our demo application, which is located in the `ExampleiOS` directory. With it, you can evaluate all the components implemented in the library in different states, with the ability to switch built-in color themes and create your own.

## General information
* Primary development language `Swift 5+`
* Supported dependency managers: `SPM (primary)`, `CocoaPods`, `Carthage`
* Minimum supported versions: `UIKit: iOS 11.0`, `SwiftUI: iOS 14.0`

### Project structure
The project is divided into 4 modules:
* `AdmiralUIResources` - all resources (icons / fonts / colors)
* `AdmiralTheme` - app theme manager
* `AdmrialUIKit`- component library on UIKit
* `AdmiralSwiftUI` - component library on SwiftUI

> The modules work independently of each other and can be connected separately. For example: if you only need icons and fonts, you should only connect `AdmiralUIResources`, and if you only need a theme manager - `AdmiralTheme`
<br/>  

## Contributors
We welcome any help, and you can help us with the development of this project. Details in [wiki](https://github.com/admiral-team/admiralui-ios/wiki/Контрибьютерам)

## Project team
<table>
  <tr>
    <td align="center"><a href="https://github.com/ton252"><img src="https://avatars.githubusercontent.com/u/13065321?v=4" width="80px;" alt="" /><br/><sub><b>Polyakov Anton</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-ios/commits?author=ton252" title="Code">👑</a></td>
    <td align="center"><a href="https://github.com/KirBorisov96"><img src="https://avatars.githubusercontent.com/u/100690555?s=400&u=4d8a4e4b4837e94735b1c42905691cf624501559&v=4" width="80px;" alt="" /><br/><sub><b>Borisov Kirill</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-ios/commits?author=KirBorisov96" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Almazovivan"><img src="https://avatars.githubusercontent.com/u/66259778?v=4" width="80px;" alt="" /><br /><sub><b>Almazov Ivan</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-ios/commits?author=Almazovivan" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Andyatkov"><img src="https://avatars.githubusercontent.com/u/8963238?v=4" width="80px;" alt="" /><br /><sub><b>Andrey Dyatkov</b></sub></a><br /><a href="https://github.com/admiral-team/admiralui-ios/commits?author=Andyatkov" title="Code">💻</a></td>
  </tr>
</table>
