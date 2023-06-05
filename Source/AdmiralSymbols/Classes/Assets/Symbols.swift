// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum AssetSymbol {
  public enum Category {
    public enum Outline {
      public static let accept = SymbolAsset(name: "Category/Outline/accept")
      public static let acuringFuture = SymbolAsset(name: "Category/Outline/acuringFuture")
      public static let acuringModern = SymbolAsset(name: "Category/Outline/acuringModern")
      public static let addCommen = SymbolAsset(name: "Category/Outline/addCommen")
      public static let alert = SymbolAsset(name: "Category/Outline/alert")
      public static let bank = SymbolAsset(name: "Category/Outline/bank")
      public static let bonus = SymbolAsset(name: "Category/Outline/bonus")
      public static let bonusRuble = SymbolAsset(name: "Category/Outline/bonusRuble")
      public static let burn = SymbolAsset(name: "Category/Outline/burn")
      public static let car = SymbolAsset(name: "Category/Outline/car")
      public static let chart = SymbolAsset(name: "Category/Outline/chart")
      public static let chat = SymbolAsset(name: "Category/Outline/chat")
      public static let chip = SymbolAsset(name: "Category/Outline/chip")
      public static let clipboard = SymbolAsset(name: "Category/Outline/clipboard")
      public static let color = SymbolAsset(name: "Category/Outline/color")
      public static let comment = SymbolAsset(name: "Category/Outline/comment")
      public static let component = SymbolAsset(name: "Category/Outline/component")
      public static let credit = SymbolAsset(name: "Category/Outline/credit")
      public static let delivery = SymbolAsset(name: "Category/Outline/delivery")
      public static let deposit = SymbolAsset(name: "Category/Outline/deposit")
      public static let desktop = SymbolAsset(name: "Category/Outline/desktop")
      public static let diamond = SymbolAsset(name: "Category/Outline/diamond")
      public static let globe = SymbolAsset(name: "Category/Outline/globe")
      public static let government = SymbolAsset(name: "Category/Outline/government")
      public static let grid = SymbolAsset(name: "Category/Outline/grid")
      public static let heart = SymbolAsset(name: "Category/Outline/heart")
      public static let homeAutocredit = SymbolAsset(name: "Category/Outline/homeAutocredit")
      public static let icons = SymbolAsset(name: "Category/Outline/icons")
      public static let idea = SymbolAsset(name: "Category/Outline/idea")
      public static let invalid = SymbolAsset(name: "Category/Outline/invalid")
      public static let layers = SymbolAsset(name: "Category/Outline/layers")
      public static let layout = SymbolAsset(name: "Category/Outline/layout")
      public static let magnet = SymbolAsset(name: "Category/Outline/magnet")
      public static let maintenance = SymbolAsset(name: "Category/Outline/maintenance")
      public static let medal = SymbolAsset(name: "Category/Outline/medal")
      public static let megaphone = SymbolAsset(name: "Category/Outline/megaphone")
      public static let mobile = SymbolAsset(name: "Category/Outline/mobile")
      public static let multibonus = SymbolAsset(name: "Category/Outline/multibonus")
      public static let pension = SymbolAsset(name: "Category/Outline/pension")
      public static let pickup = SymbolAsset(name: "Category/Outline/pickup")
      public static let pin = SymbolAsset(name: "Category/Outline/pin")
      public static let plane = SymbolAsset(name: "Category/Outline/plane")
      public static let post = SymbolAsset(name: "Category/Outline/post")
      public static let postAutomat = SymbolAsset(name: "Category/Outline/postAutomat")
      public static let pregnant = SymbolAsset(name: "Category/Outline/pregnant")
      public static let receipt = SymbolAsset(name: "Category/Outline/receipt")
      public static let scheme = SymbolAsset(name: "Category/Outline/scheme")
      public static let shopCart = SymbolAsset(name: "Category/Outline/shopCart")
      public static let shoppingBag = SymbolAsset(name: "Category/Outline/shoppingBag")
      public static let showTable = SymbolAsset(name: "Category/Outline/showTable")
      public static let store = SymbolAsset(name: "Category/Outline/store")
      public static let study = SymbolAsset(name: "Category/Outline/study")
      public static let tablet = SymbolAsset(name: "Category/Outline/tablet")
      public static let trophy = SymbolAsset(name: "Category/Outline/trophy")
      public static let typography = SymbolAsset(name: "Category/Outline/typography")
      public static let vip = SymbolAsset(name: "Category/Outline/vIP")
      public static let vacation = SymbolAsset(name: "Category/Outline/vacation")
      public static let wiki = SymbolAsset(name: "Category/Outline/wiki")
      public static let work = SymbolAsset(name: "Category/Outline/work")
    }
    public enum Solid {
      public static let accept = SymbolAsset(name: "Category/Solid/accept")
      public static let acuringFuture = SymbolAsset(name: "Category/Solid/acuringFuture")
      public static let acuringModern = SymbolAsset(name: "Category/Solid/acuringModern")
      public static let addCommen = SymbolAsset(name: "Category/Solid/addCommen")
      public static let alert = SymbolAsset(name: "Category/Solid/alert")
      public static let bank = SymbolAsset(name: "Category/Solid/bank")
      public static let bonus = SymbolAsset(name: "Category/Solid/bonus")
      public static let bonusRuble = SymbolAsset(name: "Category/Solid/bonusRuble")
      public static let burn = SymbolAsset(name: "Category/Solid/burn")
      public static let car = SymbolAsset(name: "Category/Solid/car")
      public static let chart = SymbolAsset(name: "Category/Solid/chart")
      public static let chat = SymbolAsset(name: "Category/Solid/chat")
      public static let chip = SymbolAsset(name: "Category/Solid/chip")
      public static let clipboard = SymbolAsset(name: "Category/Solid/clipboard")
      public static let color = SymbolAsset(name: "Category/Solid/color")
      public static let comment = SymbolAsset(name: "Category/Solid/comment")
      public static let component = SymbolAsset(name: "Category/Solid/component")
      public static let credit = SymbolAsset(name: "Category/Solid/credit")
      public static let delivery = SymbolAsset(name: "Category/Solid/delivery")
      public static let deposit = SymbolAsset(name: "Category/Solid/deposit")
      public static let desktop = SymbolAsset(name: "Category/Solid/desktop")
      public static let diamond = SymbolAsset(name: "Category/Solid/diamond")
      public static let globe = SymbolAsset(name: "Category/Solid/globe")
      public static let government = SymbolAsset(name: "Category/Solid/government")
      public static let grid = SymbolAsset(name: "Category/Solid/grid")
      public static let heart = SymbolAsset(name: "Category/Solid/heart")
      public static let homeAutocredit = SymbolAsset(name: "Category/Solid/homeAutocredit")
      public static let icons = SymbolAsset(name: "Category/Solid/icons")
      public static let idea = SymbolAsset(name: "Category/Solid/idea")
      public static let invalid = SymbolAsset(name: "Category/Solid/invalid")
      public static let layers = SymbolAsset(name: "Category/Solid/layers")
      public static let layout = SymbolAsset(name: "Category/Solid/layout")
      public static let magnet = SymbolAsset(name: "Category/Solid/magnet")
      public static let maintenance = SymbolAsset(name: "Category/Solid/maintenance")
      public static let medal = SymbolAsset(name: "Category/Solid/medal")
      public static let megaphone = SymbolAsset(name: "Category/Solid/megaphone")
      public static let mobile = SymbolAsset(name: "Category/Solid/mobile")
      public static let multibonus = SymbolAsset(name: "Category/Solid/multibonus")
      public static let pension = SymbolAsset(name: "Category/Solid/pension")
      public static let pickup = SymbolAsset(name: "Category/Solid/pickup")
      public static let pin = SymbolAsset(name: "Category/Solid/pin")
      public static let plane = SymbolAsset(name: "Category/Solid/plane")
      public static let post = SymbolAsset(name: "Category/Solid/post")
      public static let postAutomat = SymbolAsset(name: "Category/Solid/postAutomat")
      public static let pregnant = SymbolAsset(name: "Category/Solid/pregnant")
      public static let receipt = SymbolAsset(name: "Category/Solid/receipt")
      public static let scheme = SymbolAsset(name: "Category/Solid/scheme")
      public static let shopCart = SymbolAsset(name: "Category/Solid/shopCart")
      public static let shoppingBag = SymbolAsset(name: "Category/Solid/shoppingBag")
      public static let showTable = SymbolAsset(name: "Category/Solid/showTable")
      public static let store = SymbolAsset(name: "Category/Solid/store")
      public static let study = SymbolAsset(name: "Category/Solid/study")
      public static let tablet = SymbolAsset(name: "Category/Solid/tablet")
      public static let trophy = SymbolAsset(name: "Category/Solid/trophy")
      public static let typography = SymbolAsset(name: "Category/Solid/typography")
      public static let vip = SymbolAsset(name: "Category/Solid/vIP")
      public static let vacation = SymbolAsset(name: "Category/Solid/vacation")
      public static let wiki = SymbolAsset(name: "Category/Solid/wiki")
      public static let work = SymbolAsset(name: "Category/Solid/work")
    }
  }
  public enum Communication {
    public enum Outline {
      public static let headset = SymbolAsset(name: "Communication/Outline/headset")
      public static let phone = SymbolAsset(name: "Communication/Outline/phone")
      public static let simCard = SymbolAsset(name: "Communication/Outline/sIMCard")
      public static let signal = SymbolAsset(name: "Communication/Outline/signal")
      public static let telegramm = SymbolAsset(name: "Communication/Outline/telegramm")
    }
    public enum Solid {
      public static let headset = SymbolAsset(name: "Communication/Solid/headset")
      public static let phone = SymbolAsset(name: "Communication/Solid/phone")
      public static let simCard = SymbolAsset(name: "Communication/Solid/sIMCard")
      public static let signal = SymbolAsset(name: "Communication/Solid/signal")
      public static let telegramm = SymbolAsset(name: "Communication/Solid/telegramm")
    }
  }
  public enum Documents {
    public enum Outline {
      public static let accountDetail = SymbolAsset(name: "Documents/Outline/accountDetail")
      public static let addFromTemplate = SymbolAsset(name: "Documents/Outline/addFromTemplate")
      public static let catalog = SymbolAsset(name: "Documents/Outline/catalog")
      public static let copy = SymbolAsset(name: "Documents/Outline/copy")
      public static let description = SymbolAsset(name: "Documents/Outline/description")
      public static let docAttention = SymbolAsset(name: "Documents/Outline/docAttention")
      public static let docExport = SymbolAsset(name: "Documents/Outline/docExport")
      public static let docFinished = SymbolAsset(name: "Documents/Outline/docFinished")
      public static let docOk = SymbolAsset(name: "Documents/Outline/docOk")
      public static let docOperations = SymbolAsset(name: "Documents/Outline/docOperations")
      public static let docProcessing = SymbolAsset(name: "Documents/Outline/docProcessing")
      public static let docRegenerate = SymbolAsset(name: "Documents/Outline/docRegenerate")
      public static let docSettings = SymbolAsset(name: "Documents/Outline/docSettings")
      public static let docSign = SymbolAsset(name: "Documents/Outline/docSign")
      public static let docSignVerify = SymbolAsset(name: "Documents/Outline/docSignVerify")
      public static let docView = SymbolAsset(name: "Documents/Outline/docView")
      public static let docs = SymbolAsset(name: "Documents/Outline/docs")
      public static let documentAdd = SymbolAsset(name: "Documents/Outline/documentAdd")
      public static let filePDF = SymbolAsset(name: "Documents/Outline/filePDF")
      public static let filePPT = SymbolAsset(name: "Documents/Outline/filePPT")
      public static let fileSNG = SymbolAsset(name: "Documents/Outline/fileSNG")
      public static let fileWord = SymbolAsset(name: "Documents/Outline/fileWord")
      public static let fileXLS = SymbolAsset(name: "Documents/Outline/fileXLS")
      public static let fileXML = SymbolAsset(name: "Documents/Outline/fileXML")
      public static let folder = SymbolAsset(name: "Documents/Outline/folder")
      public static let jpg = SymbolAsset(name: "Documents/Outline/jpg")
      public static let sendSign = SymbolAsset(name: "Documents/Outline/sendSign")
      public static let sign = SymbolAsset(name: "Documents/Outline/sign")
      public static let tasks = SymbolAsset(name: "Documents/Outline/tasks")
      public static let unsign = SymbolAsset(name: "Documents/Outline/unsign")
      public static let web = SymbolAsset(name: "Documents/Outline/web")
    }
    public enum Solid {
      public static let accountDetail = SymbolAsset(name: "Documents/Solid/accountDetail")
      public static let addFromTemplate = SymbolAsset(name: "Documents/Solid/addFromTemplate")
      public static let catalog = SymbolAsset(name: "Documents/Solid/catalog")
      public static let copy = SymbolAsset(name: "Documents/Solid/copy")
      public static let description = SymbolAsset(name: "Documents/Solid/description")
      public static let docAttention = SymbolAsset(name: "Documents/Solid/docAttention")
      public static let docExport = SymbolAsset(name: "Documents/Solid/docExport")
      public static let docFinished = SymbolAsset(name: "Documents/Solid/docFinished")
      public static let docOk = SymbolAsset(name: "Documents/Solid/docOk")
      public static let docOperations = SymbolAsset(name: "Documents/Solid/docOperations")
      public static let docProcessing = SymbolAsset(name: "Documents/Solid/docProcessing")
      public static let docRegenerate = SymbolAsset(name: "Documents/Solid/docRegenerate")
      public static let docSettings = SymbolAsset(name: "Documents/Solid/docSettings")
      public static let docSign = SymbolAsset(name: "Documents/Solid/docSign")
      public static let docSignVerify = SymbolAsset(name: "Documents/Solid/docSignVerify")
      public static let docView = SymbolAsset(name: "Documents/Solid/docView")
      public static let docs = SymbolAsset(name: "Documents/Solid/docs")
      public static let documentAdd = SymbolAsset(name: "Documents/Solid/documentAdd")
      public static let filePDF = SymbolAsset(name: "Documents/Solid/filePDF")
      public static let filePPT = SymbolAsset(name: "Documents/Solid/filePPT")
      public static let fileSNG = SymbolAsset(name: "Documents/Solid/fileSNG")
      public static let fileWord = SymbolAsset(name: "Documents/Solid/fileWord")
      public static let fileXLS = SymbolAsset(name: "Documents/Solid/fileXLS")
      public static let fileXML = SymbolAsset(name: "Documents/Solid/fileXML")
      public static let folder = SymbolAsset(name: "Documents/Solid/folder")
      public static let jpg = SymbolAsset(name: "Documents/Solid/jpg")
      public static let sendSign = SymbolAsset(name: "Documents/Solid/sendSign")
      public static let sign = SymbolAsset(name: "Documents/Solid/sign")
      public static let tasks = SymbolAsset(name: "Documents/Solid/tasks")
      public static let unsign = SymbolAsset(name: "Documents/Solid/unsign")
      public static let web = SymbolAsset(name: "Documents/Solid/web")
    }
  }
  public enum Finance {
    public enum Outline {
      public static let card = SymbolAsset(name: "Finance/Outline/card")
      public static let credit = SymbolAsset(name: "Finance/Outline/credit")
      public static let debitCard = SymbolAsset(name: "Finance/Outline/debitCard")
      public static let eur = SymbolAsset(name: "Finance/Outline/eUR")
      public static let finance = SymbolAsset(name: "Finance/Outline/finance")
      public static let gbp = SymbolAsset(name: "Finance/Outline/gBP")
      public static let getCash = SymbolAsset(name: "Finance/Outline/getCash")
      public static let jpy = SymbolAsset(name: "Finance/Outline/jPY")
      public static let money = SymbolAsset(name: "Finance/Outline/money")
      public static let multicurency = SymbolAsset(name: "Finance/Outline/multicurency")
      public static let payrollCard = SymbolAsset(name: "Finance/Outline/payrollCard")
      public static let person = SymbolAsset(name: "Finance/Outline/person")
      public static let rub = SymbolAsset(name: "Finance/Outline/rUB")
      public static let usd = SymbolAsset(name: "Finance/Outline/uSD")
    }
    public enum Solid {
      public static let card = SymbolAsset(name: "Finance/Solid/card")
      public static let credit = SymbolAsset(name: "Finance/Solid/credit")
      public static let debitCard = SymbolAsset(name: "Finance/Solid/debitCard")
      public static let eur = SymbolAsset(name: "Finance/Solid/eUR")
      public static let finance = SymbolAsset(name: "Finance/Solid/finance")
      public static let gbp = SymbolAsset(name: "Finance/Solid/gBP")
      public static let getCash = SymbolAsset(name: "Finance/Solid/getCash")
      public static let jpy = SymbolAsset(name: "Finance/Solid/jPY")
      public static let money = SymbolAsset(name: "Finance/Solid/money")
      public static let multicurency = SymbolAsset(name: "Finance/Solid/multicurency")
      public static let payrollCard = SymbolAsset(name: "Finance/Solid/payrollCard")
      public static let person = SymbolAsset(name: "Finance/Solid/person")
      public static let rub = SymbolAsset(name: "Finance/Solid/rUB")
      public static let usd = SymbolAsset(name: "Finance/Solid/uSD")
    }
  }
  public enum Location {
    public enum Outline {
      public static let gps = SymbolAsset(name: "Location/Outline/gPS")
      public static let location = SymbolAsset(name: "Location/Outline/location")
    }
    public enum Solid {
      public static let gps = SymbolAsset(name: "Location/Solid/gPS")
      public static let location = SymbolAsset(name: "Location/Solid/location")
    }
  }
  public enum Security {
    public enum Outline {
      public static let faceID = SymbolAsset(name: "Security/Outline/faceID")
      public static let fingerprint = SymbolAsset(name: "Security/Outline/fingerprint")
      public static let key = SymbolAsset(name: "Security/Outline/key")
      public static let lock = SymbolAsset(name: "Security/Outline/lock")
      public static let password = SymbolAsset(name: "Security/Outline/password")
      public static let unlock = SymbolAsset(name: "Security/Outline/unlock")
    }
    public enum Solid {
      public static let faceID = SymbolAsset(name: "Security/Solid/faceID")
      public static let fingerprint = SymbolAsset(name: "Security/Solid/fingerprint")
      public static let key = SymbolAsset(name: "Security/Solid/key")
      public static let lock = SymbolAsset(name: "Security/Solid/lock")
      public static let password = SymbolAsset(name: "Security/Solid/password")
      public static let unlock = SymbolAsset(name: "Security/Solid/unlock")
    }
  }
  public enum Service {
    public enum Outline {
      public static let archive = SymbolAsset(name: "Service/Outline/archive")
      public static let check = SymbolAsset(name: "Service/Outline/check")
      public static let checkClear = SymbolAsset(name: "Service/Outline/checkClear")
      public static let close = SymbolAsset(name: "Service/Outline/close")
      public static let closeCircle = SymbolAsset(name: "Service/Outline/closeCircle")
      public static let drag = SymbolAsset(name: "Service/Outline/drag")
      public static let error = SymbolAsset(name: "Service/Outline/error")
      public static let errorTriangle = SymbolAsset(name: "Service/Outline/errorTriangle")
      public static let eye = SymbolAsset(name: "Service/Outline/eye")
      public static let eyeClose = SymbolAsset(name: "Service/Outline/eyeClose")
      public static let help = SymbolAsset(name: "Service/Outline/help")
      public static let info = SymbolAsset(name: "Service/Outline/info")
      public static let menu = SymbolAsset(name: "Service/Outline/menu")
      public static let minus = SymbolAsset(name: "Service/Outline/minus")
      public static let minusCircle = SymbolAsset(name: "Service/Outline/minusCircle")
      public static let pause = SymbolAsset(name: "Service/Outline/pause")
      public static let play = SymbolAsset(name: "Service/Outline/play")
      public static let plus = SymbolAsset(name: "Service/Outline/plus")
      public static let plusCircle = SymbolAsset(name: "Service/Outline/plusCircle")
      public static let process = SymbolAsset(name: "Service/Outline/process")
    }
    public enum Solid {
      public static let archive = SymbolAsset(name: "Service/Solid/archive")
      public static let check = SymbolAsset(name: "Service/Solid/check")
      public static let close = SymbolAsset(name: "Service/Solid/close")
      public static let closeCircle = SymbolAsset(name: "Service/Solid/closeCircle")
      public static let drag = SymbolAsset(name: "Service/Solid/drag")
      public static let error = SymbolAsset(name: "Service/Solid/error")
      public static let errorTriangle = SymbolAsset(name: "Service/Solid/errorTriangle")
      public static let eye = SymbolAsset(name: "Service/Solid/eye")
      public static let help = SymbolAsset(name: "Service/Solid/help")
      public static let info = SymbolAsset(name: "Service/Solid/info")
      public static let menu = SymbolAsset(name: "Service/Solid/menu")
      public static let minusCircle = SymbolAsset(name: "Service/Solid/minusCircle")
      public static let pause = SymbolAsset(name: "Service/Solid/pause")
      public static let play = SymbolAsset(name: "Service/Solid/play")
      public static let plus = SymbolAsset(name: "Service/Solid/plus")
      public static let plusCircle = SymbolAsset(name: "Service/Solid/plusCircle")
      public static let process = SymbolAsset(name: "Service/Solid/process")
    }
  }
  public enum System {
    public enum Outline {
      public static let arrowCross = SymbolAsset(name: "System/Outline/arrowCross")
      public static let arrowDown = SymbolAsset(name: "System/Outline/arrowDown")
      public static let arrowLeft = SymbolAsset(name: "System/Outline/arrowLeft")
      public static let arrowRight = SymbolAsset(name: "System/Outline/arrowRight")
      public static let arrowUp = SymbolAsset(name: "System/Outline/arrowUp")
      public static let arrowsHorizontal = SymbolAsset(name: "System/Outline/arrowsHorizontal")
      public static let arrowsVertical = SymbolAsset(name: "System/Outline/arrowsVertical")
      public static let attachFile = SymbolAsset(name: "System/Outline/attachFile")
      public static let back = SymbolAsset(name: "System/Outline/back")
      public static let barCode = SymbolAsset(name: "System/Outline/barCode")
      public static let calculate = SymbolAsset(name: "System/Outline/calculate")
      public static let calendar = SymbolAsset(name: "System/Outline/calendar")
      public static let calendarOk = SymbolAsset(name: "System/Outline/calendarOk")
      public static let camera = SymbolAsset(name: "System/Outline/camera")
      public static let cameraRemove = SymbolAsset(name: "System/Outline/cameraRemove")
      public static let chevronDown = SymbolAsset(name: "System/Outline/chevronDown")
      public static let chevronLeft = SymbolAsset(name: "System/Outline/chevronLeft")
      public static let chevronRight = SymbolAsset(name: "System/Outline/chevronRight")
      public static let chevronUp = SymbolAsset(name: "System/Outline/chevronUp")
      public static let closeFullscreen = SymbolAsset(name: "System/Outline/closeFullscreen")
      public static let darkMode = SymbolAsset(name: "System/Outline/darkMode")
      public static let delete = SymbolAsset(name: "System/Outline/delete")
      public static let download = SymbolAsset(name: "System/Outline/download")
      public static let edit = SymbolAsset(name: "System/Outline/edit")
      public static let email = SymbolAsset(name: "System/Outline/email")
      public static let emailRead = SymbolAsset(name: "System/Outline/emailRead")
      public static let exit = SymbolAsset(name: "System/Outline/exit")
      public static let export = SymbolAsset(name: "System/Outline/export")
      public static let eyedropper = SymbolAsset(name: "System/Outline/eyedropper")
      public static let filter = SymbolAsset(name: "System/Outline/filter")
      public static let home = SymbolAsset(name: "System/Outline/home")
      public static let `import` = SymbolAsset(name: "System/Outline/import")
      public static let keyboard = SymbolAsset(name: "System/Outline/keyboard")
      public static let link = SymbolAsset(name: "System/Outline/link")
      public static let loader = SymbolAsset(name: "System/Outline/loader")
      public static let moreHorizontal = SymbolAsset(name: "System/Outline/moreHorizontal")
      public static let moreVertical = SymbolAsset(name: "System/Outline/moreVertical")
      public static let notifications = SymbolAsset(name: "System/Outline/notifications")
      public static let okSend = SymbolAsset(name: "System/Outline/okSend")
      public static let openInFull = SymbolAsset(name: "System/Outline/openInFull")
      public static let people = SymbolAsset(name: "System/Outline/people")
      public static let person = SymbolAsset(name: "System/Outline/person")
      public static let personAdd = SymbolAsset(name: "System/Outline/personAdd")
      public static let personProperties = SymbolAsset(name: "System/Outline/personProperties")
      public static let power = SymbolAsset(name: "System/Outline/power")
      public static let print = SymbolAsset(name: "System/Outline/print")
      public static let qrCode = SymbolAsset(name: "System/Outline/qRCode")
      public static let redo = SymbolAsset(name: "System/Outline/redo")
      public static let refuse = SymbolAsset(name: "System/Outline/refuse")
      public static let report = SymbolAsset(name: "System/Outline/report")
      public static let save = SymbolAsset(name: "System/Outline/save")
      public static let search = SymbolAsset(name: "System/Outline/search")
      public static let settings = SymbolAsset(name: "System/Outline/settings")
      public static let smallArrowDown = SymbolAsset(name: "System/Outline/smallArrowDown")
      public static let smallArrowLeft = SymbolAsset(name: "System/Outline/smallArrowLeft")
      public static let smallArrowRight = SymbolAsset(name: "System/Outline/smallArrowRight")
      public static let smallArrowUp = SymbolAsset(name: "System/Outline/smallArrowUp")
      public static let star = SymbolAsset(name: "System/Outline/star")
      public static let thirdPerson = SymbolAsset(name: "System/Outline/thirdPerson")
      public static let time = SymbolAsset(name: "System/Outline/time")
      public static let toCustomer = SymbolAsset(name: "System/Outline/toCustomer")
      public static let tune = SymbolAsset(name: "System/Outline/tune")
      public static let undo = SymbolAsset(name: "System/Outline/undo")
      public static let update = SymbolAsset(name: "System/Outline/update")
      public static let upload = SymbolAsset(name: "System/Outline/upload")
      public static let userDelete = SymbolAsset(name: "System/Outline/userDelete")
      public static let userRole = SymbolAsset(name: "System/Outline/userRole")
      public static let zoomIn = SymbolAsset(name: "System/Outline/zoomIn")
      public static let zoomOut = SymbolAsset(name: "System/Outline/zoomOut")
    }
    public enum Solid {
      public static let arrowCross = SymbolAsset(name: "System/Solid/arrowCross")
      public static let arrowDown = SymbolAsset(name: "System/Solid/arrowDown")
      public static let arrowLeft = SymbolAsset(name: "System/Solid/arrowLeft")
      public static let arrowRight = SymbolAsset(name: "System/Solid/arrowRight")
      public static let arrowUp = SymbolAsset(name: "System/Solid/arrowUp")
      public static let arrowsHorizontal = SymbolAsset(name: "System/Solid/arrowsHorizontal")
      public static let arrowsVertical = SymbolAsset(name: "System/Solid/arrowsVertical")
      public static let attachFile = SymbolAsset(name: "System/Solid/attachFile")
      public static let back = SymbolAsset(name: "System/Solid/back")
      public static let barCode = SymbolAsset(name: "System/Solid/barCode")
      public static let calculate = SymbolAsset(name: "System/Solid/calculate")
      public static let calendar = SymbolAsset(name: "System/Solid/calendar")
      public static let calendarOk = SymbolAsset(name: "System/Solid/calendarOk")
      public static let camera = SymbolAsset(name: "System/Solid/camera")
      public static let cameraRemove = SymbolAsset(name: "System/Solid/cameraRemove")
      public static let chevronDown = SymbolAsset(name: "System/Solid/chevronDown")
      public static let chevronLeft = SymbolAsset(name: "System/Solid/chevronLeft")
      public static let chevronRight = SymbolAsset(name: "System/Solid/chevronRight")
      public static let chevronUp = SymbolAsset(name: "System/Solid/chevronUp")
      public static let closeFullscreen = SymbolAsset(name: "System/Solid/closeFullscreen")
      public static let darkMode = SymbolAsset(name: "System/Solid/darkMode")
      public static let delete = SymbolAsset(name: "System/Solid/delete")
      public static let download = SymbolAsset(name: "System/Solid/download")
      public static let edit = SymbolAsset(name: "System/Solid/edit")
      public static let email = SymbolAsset(name: "System/Solid/email")
      public static let emailRead = SymbolAsset(name: "System/Solid/emailRead")
      public static let exit = SymbolAsset(name: "System/Solid/exit")
      public static let export = SymbolAsset(name: "System/Solid/export")
      public static let eyedropper = SymbolAsset(name: "System/Solid/eyedropper")
      public static let filter = SymbolAsset(name: "System/Solid/filter")
      public static let home = SymbolAsset(name: "System/Solid/home")
      public static let `import` = SymbolAsset(name: "System/Solid/import")
      public static let keyboard = SymbolAsset(name: "System/Solid/keyboard")
      public static let link = SymbolAsset(name: "System/Solid/link")
      public static let loader = SymbolAsset(name: "System/Solid/loader")
      public static let moreHorizontal = SymbolAsset(name: "System/Solid/moreHorizontal")
      public static let moreVertical = SymbolAsset(name: "System/Solid/moreVertical")
      public static let notifications = SymbolAsset(name: "System/Solid/notifications")
      public static let okSend = SymbolAsset(name: "System/Solid/okSend")
      public static let openInFull = SymbolAsset(name: "System/Solid/openInFull")
      public static let people = SymbolAsset(name: "System/Solid/people")
      public static let person = SymbolAsset(name: "System/Solid/person")
      public static let personAdd = SymbolAsset(name: "System/Solid/personAdd")
      public static let personProperties = SymbolAsset(name: "System/Solid/personProperties")
      public static let power = SymbolAsset(name: "System/Solid/power")
      public static let print = SymbolAsset(name: "System/Solid/print")
      public static let qrCode = SymbolAsset(name: "System/Solid/qRCode")
      public static let redo = SymbolAsset(name: "System/Solid/redo")
      public static let refuse = SymbolAsset(name: "System/Solid/refuse")
      public static let report = SymbolAsset(name: "System/Solid/report")
      public static let save = SymbolAsset(name: "System/Solid/save")
      public static let search = SymbolAsset(name: "System/Solid/search")
      public static let settings = SymbolAsset(name: "System/Solid/settings")
      public static let smallArrowDown = SymbolAsset(name: "System/Solid/smallArrowDown")
      public static let smallArrowLeft = SymbolAsset(name: "System/Solid/smallArrowLeft")
      public static let smallArrowRight = SymbolAsset(name: "System/Solid/smallArrowRight")
      public static let smallArrowUp = SymbolAsset(name: "System/Solid/smallArrowUp")
      public static let star = SymbolAsset(name: "System/Solid/star")
      public static let thirdPerson = SymbolAsset(name: "System/Solid/thirdPerson")
      public static let time = SymbolAsset(name: "System/Solid/time")
      public static let toCustomer = SymbolAsset(name: "System/Solid/toCustomer")
      public static let tune = SymbolAsset(name: "System/Solid/tune")
      public static let undo = SymbolAsset(name: "System/Solid/undo")
      public static let update = SymbolAsset(name: "System/Solid/update")
      public static let upload = SymbolAsset(name: "System/Solid/upload")
      public static let userDelete = SymbolAsset(name: "System/Solid/userDelete")
      public static let userRole = SymbolAsset(name: "System/Solid/userRole")
      public static let zoomIn = SymbolAsset(name: "System/Solid/zoomIn")
      public static let zoomOut = SymbolAsset(name: "System/Solid/zoomOut")
    }
  }

  // swiftlint:disable trailing_comma
  public static let allSymbols: [SymbolAsset] = [
    Category.Outline.accept,
    Category.Outline.acuringFuture,
    Category.Outline.acuringModern,
    Category.Outline.addCommen,
    Category.Outline.alert,
    Category.Outline.bank,
    Category.Outline.bonus,
    Category.Outline.bonusRuble,
    Category.Outline.burn,
    Category.Outline.car,
    Category.Outline.chart,
    Category.Outline.chat,
    Category.Outline.chip,
    Category.Outline.clipboard,
    Category.Outline.color,
    Category.Outline.comment,
    Category.Outline.component,
    Category.Outline.credit,
    Category.Outline.delivery,
    Category.Outline.deposit,
    Category.Outline.desktop,
    Category.Outline.diamond,
    Category.Outline.globe,
    Category.Outline.government,
    Category.Outline.grid,
    Category.Outline.heart,
    Category.Outline.homeAutocredit,
    Category.Outline.icons,
    Category.Outline.idea,
    Category.Outline.invalid,
    Category.Outline.layers,
    Category.Outline.layout,
    Category.Outline.magnet,
    Category.Outline.maintenance,
    Category.Outline.medal,
    Category.Outline.megaphone,
    Category.Outline.mobile,
    Category.Outline.multibonus,
    Category.Outline.pension,
    Category.Outline.pickup,
    Category.Outline.pin,
    Category.Outline.plane,
    Category.Outline.post,
    Category.Outline.postAutomat,
    Category.Outline.pregnant,
    Category.Outline.receipt,
    Category.Outline.scheme,
    Category.Outline.shopCart,
    Category.Outline.shoppingBag,
    Category.Outline.showTable,
    Category.Outline.store,
    Category.Outline.study,
    Category.Outline.tablet,
    Category.Outline.trophy,
    Category.Outline.typography,
    Category.Outline.vip,
    Category.Outline.vacation,
    Category.Outline.wiki,
    Category.Outline.work,
    Category.Solid.accept,
    Category.Solid.acuringFuture,
    Category.Solid.acuringModern,
    Category.Solid.addCommen,
    Category.Solid.alert,
    Category.Solid.bank,
    Category.Solid.bonus,
    Category.Solid.bonusRuble,
    Category.Solid.burn,
    Category.Solid.car,
    Category.Solid.chart,
    Category.Solid.chat,
    Category.Solid.chip,
    Category.Solid.clipboard,
    Category.Solid.color,
    Category.Solid.comment,
    Category.Solid.component,
    Category.Solid.credit,
    Category.Solid.delivery,
    Category.Solid.deposit,
    Category.Solid.desktop,
    Category.Solid.diamond,
    Category.Solid.globe,
    Category.Solid.government,
    Category.Solid.grid,
    Category.Solid.heart,
    Category.Solid.homeAutocredit,
    Category.Solid.icons,
    Category.Solid.idea,
    Category.Solid.invalid,
    Category.Solid.layers,
    Category.Solid.layout,
    Category.Solid.magnet,
    Category.Solid.maintenance,
    Category.Solid.medal,
    Category.Solid.megaphone,
    Category.Solid.mobile,
    Category.Solid.multibonus,
    Category.Solid.pension,
    Category.Solid.pickup,
    Category.Solid.pin,
    Category.Solid.plane,
    Category.Solid.post,
    Category.Solid.postAutomat,
    Category.Solid.pregnant,
    Category.Solid.receipt,
    Category.Solid.scheme,
    Category.Solid.shopCart,
    Category.Solid.shoppingBag,
    Category.Solid.showTable,
    Category.Solid.store,
    Category.Solid.study,
    Category.Solid.tablet,
    Category.Solid.trophy,
    Category.Solid.typography,
    Category.Solid.vip,
    Category.Solid.vacation,
    Category.Solid.wiki,
    Category.Solid.work,
    Communication.Outline.headset,
    Communication.Outline.phone,
    Communication.Outline.simCard,
    Communication.Outline.signal,
    Communication.Outline.telegramm,
    Communication.Solid.headset,
    Communication.Solid.phone,
    Communication.Solid.simCard,
    Communication.Solid.signal,
    Communication.Solid.telegramm,
    Documents.Outline.accountDetail,
    Documents.Outline.addFromTemplate,
    Documents.Outline.catalog,
    Documents.Outline.copy,
    Documents.Outline.description,
    Documents.Outline.docAttention,
    Documents.Outline.docExport,
    Documents.Outline.docFinished,
    Documents.Outline.docOk,
    Documents.Outline.docOperations,
    Documents.Outline.docProcessing,
    Documents.Outline.docRegenerate,
    Documents.Outline.docSettings,
    Documents.Outline.docSign,
    Documents.Outline.docSignVerify,
    Documents.Outline.docView,
    Documents.Outline.docs,
    Documents.Outline.documentAdd,
    Documents.Outline.filePDF,
    Documents.Outline.filePPT,
    Documents.Outline.fileSNG,
    Documents.Outline.fileWord,
    Documents.Outline.fileXLS,
    Documents.Outline.fileXML,
    Documents.Outline.folder,
    Documents.Outline.jpg,
    Documents.Outline.sendSign,
    Documents.Outline.sign,
    Documents.Outline.tasks,
    Documents.Outline.unsign,
    Documents.Outline.web,
    Documents.Solid.accountDetail,
    Documents.Solid.addFromTemplate,
    Documents.Solid.catalog,
    Documents.Solid.copy,
    Documents.Solid.description,
    Documents.Solid.docAttention,
    Documents.Solid.docExport,
    Documents.Solid.docFinished,
    Documents.Solid.docOk,
    Documents.Solid.docOperations,
    Documents.Solid.docProcessing,
    Documents.Solid.docRegenerate,
    Documents.Solid.docSettings,
    Documents.Solid.docSign,
    Documents.Solid.docSignVerify,
    Documents.Solid.docView,
    Documents.Solid.docs,
    Documents.Solid.documentAdd,
    Documents.Solid.filePDF,
    Documents.Solid.filePPT,
    Documents.Solid.fileSNG,
    Documents.Solid.fileWord,
    Documents.Solid.fileXLS,
    Documents.Solid.fileXML,
    Documents.Solid.folder,
    Documents.Solid.jpg,
    Documents.Solid.sendSign,
    Documents.Solid.sign,
    Documents.Solid.tasks,
    Documents.Solid.unsign,
    Documents.Solid.web,
    Finance.Outline.card,
    Finance.Outline.credit,
    Finance.Outline.debitCard,
    Finance.Outline.eur,
    Finance.Outline.finance,
    Finance.Outline.gbp,
    Finance.Outline.getCash,
    Finance.Outline.jpy,
    Finance.Outline.money,
    Finance.Outline.multicurency,
    Finance.Outline.payrollCard,
    Finance.Outline.person,
    Finance.Outline.rub,
    Finance.Outline.usd,
    Finance.Solid.card,
    Finance.Solid.credit,
    Finance.Solid.debitCard,
    Finance.Solid.eur,
    Finance.Solid.finance,
    Finance.Solid.gbp,
    Finance.Solid.getCash,
    Finance.Solid.jpy,
    Finance.Solid.money,
    Finance.Solid.multicurency,
    Finance.Solid.payrollCard,
    Finance.Solid.person,
    Finance.Solid.rub,
    Finance.Solid.usd,
    Location.Outline.gps,
    Location.Outline.location,
    Location.Solid.gps,
    Location.Solid.location,
    Security.Outline.faceID,
    Security.Outline.fingerprint,
    Security.Outline.key,
    Security.Outline.lock,
    Security.Outline.password,
    Security.Outline.unlock,
    Security.Solid.faceID,
    Security.Solid.fingerprint,
    Security.Solid.key,
    Security.Solid.lock,
    Security.Solid.password,
    Security.Solid.unlock,
    Service.Outline.archive,
    Service.Outline.check,
    Service.Outline.checkClear,
    Service.Outline.close,
    Service.Outline.closeCircle,
    Service.Outline.drag,
    Service.Outline.error,
    Service.Outline.errorTriangle,
    Service.Outline.eye,
    Service.Outline.eyeClose,
    Service.Outline.help,
    Service.Outline.info,
    Service.Outline.menu,
    Service.Outline.minus,
    Service.Outline.minusCircle,
    Service.Outline.pause,
    Service.Outline.play,
    Service.Outline.plus,
    Service.Outline.plusCircle,
    Service.Outline.process,
    Service.Solid.archive,
    Service.Solid.check,
    Service.Solid.close,
    Service.Solid.closeCircle,
    Service.Solid.drag,
    Service.Solid.error,
    Service.Solid.errorTriangle,
    Service.Solid.eye,
    Service.Solid.help,
    Service.Solid.info,
    Service.Solid.menu,
    Service.Solid.minusCircle,
    Service.Solid.pause,
    Service.Solid.play,
    Service.Solid.plus,
    Service.Solid.plusCircle,
    Service.Solid.process,
    System.Outline.arrowCross,
    System.Outline.arrowDown,
    System.Outline.arrowLeft,
    System.Outline.arrowRight,
    System.Outline.arrowUp,
    System.Outline.arrowsHorizontal,
    System.Outline.arrowsVertical,
    System.Outline.attachFile,
    System.Outline.back,
    System.Outline.barCode,
    System.Outline.calculate,
    System.Outline.calendar,
    System.Outline.calendarOk,
    System.Outline.camera,
    System.Outline.cameraRemove,
    System.Outline.chevronDown,
    System.Outline.chevronLeft,
    System.Outline.chevronRight,
    System.Outline.chevronUp,
    System.Outline.closeFullscreen,
    System.Outline.darkMode,
    System.Outline.delete,
    System.Outline.download,
    System.Outline.edit,
    System.Outline.email,
    System.Outline.emailRead,
    System.Outline.exit,
    System.Outline.export,
    System.Outline.eyedropper,
    System.Outline.filter,
    System.Outline.home,
    System.Outline.`import`,
    System.Outline.keyboard,
    System.Outline.link,
    System.Outline.loader,
    System.Outline.moreHorizontal,
    System.Outline.moreVertical,
    System.Outline.notifications,
    System.Outline.okSend,
    System.Outline.openInFull,
    System.Outline.people,
    System.Outline.person,
    System.Outline.personAdd,
    System.Outline.personProperties,
    System.Outline.power,
    System.Outline.print,
    System.Outline.qrCode,
    System.Outline.redo,
    System.Outline.refuse,
    System.Outline.report,
    System.Outline.save,
    System.Outline.search,
    System.Outline.settings,
    System.Outline.smallArrowDown,
    System.Outline.smallArrowLeft,
    System.Outline.smallArrowRight,
    System.Outline.smallArrowUp,
    System.Outline.star,
    System.Outline.thirdPerson,
    System.Outline.time,
    System.Outline.toCustomer,
    System.Outline.tune,
    System.Outline.undo,
    System.Outline.update,
    System.Outline.upload,
    System.Outline.userDelete,
    System.Outline.userRole,
    System.Outline.zoomIn,
    System.Outline.zoomOut,
    System.Solid.arrowCross,
    System.Solid.arrowDown,
    System.Solid.arrowLeft,
    System.Solid.arrowRight,
    System.Solid.arrowUp,
    System.Solid.arrowsHorizontal,
    System.Solid.arrowsVertical,
    System.Solid.attachFile,
    System.Solid.back,
    System.Solid.barCode,
    System.Solid.calculate,
    System.Solid.calendar,
    System.Solid.calendarOk,
    System.Solid.camera,
    System.Solid.cameraRemove,
    System.Solid.chevronDown,
    System.Solid.chevronLeft,
    System.Solid.chevronRight,
    System.Solid.chevronUp,
    System.Solid.closeFullscreen,
    System.Solid.darkMode,
    System.Solid.delete,
    System.Solid.download,
    System.Solid.edit,
    System.Solid.email,
    System.Solid.emailRead,
    System.Solid.exit,
    System.Solid.export,
    System.Solid.eyedropper,
    System.Solid.filter,
    System.Solid.home,
    System.Solid.`import`,
    System.Solid.keyboard,
    System.Solid.link,
    System.Solid.loader,
    System.Solid.moreHorizontal,
    System.Solid.moreVertical,
    System.Solid.notifications,
    System.Solid.okSend,
    System.Solid.openInFull,
    System.Solid.people,
    System.Solid.person,
    System.Solid.personAdd,
    System.Solid.personProperties,
    System.Solid.power,
    System.Solid.print,
    System.Solid.qrCode,
    System.Solid.redo,
    System.Solid.refuse,
    System.Solid.report,
    System.Solid.save,
    System.Solid.search,
    System.Solid.settings,
    System.Solid.smallArrowDown,
    System.Solid.smallArrowLeft,
    System.Solid.smallArrowRight,
    System.Solid.smallArrowUp,
    System.Solid.star,
    System.Solid.thirdPerson,
    System.Solid.time,
    System.Solid.toCustomer,
    System.Solid.tune,
    System.Solid.undo,
    System.Solid.update,
    System.Solid.upload,
    System.Solid.userDelete,
    System.Solid.userRole,
    System.Solid.zoomIn,
    System.Solid.zoomOut,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct SymbolAsset {
  public fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(watchOS)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  public typealias Configuration = UIImage.SymbolConfiguration
  public typealias Image = UIImage

  @available(iOS 12.0, tvOS 12.0, watchOS 5.0, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load symbol asset named \(name).")
    }
    return result
  }

  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  public func image(with configuration: Configuration) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, with: configuration) else {
      fatalError("Unable to load symbol asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: SymbolAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: SymbolAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: SymbolAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
