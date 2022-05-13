//
//  SwiftUIItem.swift
//  ExampleiOS
//
//  Created on 15.04.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum SwiftUIItem: String, CaseIterable {
    case themes
    case buttons
    case textFields
    case cells
    case textBlocks
    case tabs
    case informers
    case tags
    case badges
    case radioButton
    case checkbox
    case switcher
    case links
    case spiner
    case pageControls
    case shimmers
    case calendar
    case timePicker
    case alert
    case toolBar
    case bottomSheets
    case currency
    case chat
    case admiralGun
    
    var title: String {
        switch self {
        case .themes:
            return "Themes"
        case .buttons:
            return "Buttons"
        case .textFields:
            return "TextFields"
        case .cells:
            return "Cells"
        case .textBlocks:
            return "Text Blocks"
        case .tabs:
            return "Tabs"
        case .informers:
            return "Informers & Notifications"
        case .tags:
            return "Tags & Chips"
        case .badges:
            return "Badges"
        case .radioButton:
            return "RadioButton"
        case .checkbox:
            return "Сheckbox"
        case .switcher:
            return "Switcher"
        case .links:
            return "Links"
        case .spiner:
            return "Spiner"
        case .pageControls:
            return "Page Controls"
        case .shimmers:
            return "Shimmers"
        case .timePicker:
            return "Time Picker"
        case .calendar:
            return "Calendar"
        case .alert:
            return "Alerts"
        case .toolBar:
            return "Tool bar"
        case .bottomSheets:
            return "Bottom sheets"
        case .currency:
            return "Currency"
        case .chat :
            return "Chat"
        case .admiralGun:
            return "Admiral Gun"
        }
    }
    
    var subtitle: String {
        switch self {
        case .themes:
            return "Цветовая палитра и схема"
        case .buttons:
            return "Кнопки"
        case .textFields:
            return "Поля ввода"
        case .cells:
            return "Списки"
        case .textBlocks:
            return "Текстовые блоки"
        case .tabs:
            return "Вкладки"
        case .informers:
            return "Информеры"
        case .tags:
            return "Тэги и чипсы"
        case .badges:
            return "Количественные значения"
        case .radioButton:
            return "Радио кнопка"
        case .checkbox:
            return "Селектор"
        case .switcher:
            return "Переключатель"
        case .links:
            return "Ссылки"
        case .spiner:
            return "Демонстрация процесса загрузки"
        case .pageControls:
            return "Прогресс просмотра страниц"
        case .shimmers:
            return "Демонстрация процесса загрузки"
        case .timePicker:
            return "Выбор времени"
        case .calendar:
            return "Каледарь"
        case .alert:
            return "Информирующие сообщения"
        case .toolBar:
            return "Панель инструментов"
        case .bottomSheets:
            return "Информационная панель"
        case .currency:
            return "Таблица курсов валют"
        case .chat:
            return "Чат"
        case .admiralGun:
            return "Загрузка шаблонов"
        }
    }
    
    var imageName: String {
        switch self {
        case .themes:
            return Asset.Main.pencil.name
        case .buttons:
            return Asset.Main.main.name
        case .textFields:
            return Asset.Main.draw.name
        case .cells:
            return Asset.Main.list.name
        case .tabs:
            return Asset.Main.gem.name
        case .informers:
            return Asset.Main.chat.name
        case .tags:
            return Asset.Main.pin.name
        case .badges:
            return Asset.Main.badges.name
        case .radioButton:
            return Asset.Main.radiobuttons.name
        case .checkbox:
            return Asset.Main.gem.name
        case .switcher:
            return Asset.Main.checkboxes.name
        case .links:
            return Asset.Main.links.name
        case .spiner:
            return Asset.Main.spinner.name
        case .pageControls:
            return Asset.Main.pageControls.name
        case .shimmers:
            return Asset.Main.refresh.name
        case .timePicker:
            return Asset.Main.time.name
        case .calendar:
            return Asset.Main.calendar.name
        case .alert:
            return Asset.Main.envelope.name
        case .toolBar:
            return Asset.Main.chat.name
        case .bottomSheets:
            return Asset.Main.bottomSheets.name
        case .currency:
            return Asset.Main.currency.name
        case .textBlocks:
            return Asset.Main.textBlocks.name
        case .chat:
            return Asset.Main.chat.name
        case .admiralGun:
            return Asset.Main.pencil.name
        }
    }
    
    var image: Image {
        return Image(self.imageName)
    }
}
