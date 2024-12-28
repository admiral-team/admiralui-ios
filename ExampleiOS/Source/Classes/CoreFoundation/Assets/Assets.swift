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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum ActionBar {
    public static let arrowDownOutline = ImageAsset(name: "ActionBar/ArrowDownOutline")
    public static let arrowUpOutline = ImageAsset(name: "ActionBar/ArrowUpOutline")
    public static let closeOutline = ImageAsset(name: "ActionBar/CloseOutline")
    public static let moreOutline = ImageAsset(name: "ActionBar/MoreOutline")
    public static let shape = ImageAsset(name: "ActionBar/Shape")
    public static let union = ImageAsset(name: "ActionBar/Union")
    public static let mail = ImageAsset(name: "ActionBar/mail")
  }
  public enum Badges {
    public static let bonus = ImageAsset(name: "Badges/Bonus")
    public static let diamondSolid = ImageAsset(name: "Badges/diamondSolid")
  }
  public enum Card {
    public static let mir = ImageAsset(name: "Card/Mir")
    public static let visa = ImageAsset(name: "Card/Visa")
    public static let applePay = ImageAsset(name: "Card/applePay")
    public static let appleWallet = ImageAsset(name: "Card/appleWallet")
    public static let googlePay = ImageAsset(name: "Card/googlePay")
    public static let info = ImageAsset(name: "Card/info")
    public static let rnb = ImageAsset(name: "Card/rnb")
    public static let visaLabel = ImageAsset(name: "Card/visaLabel")
    public static let warning = ImageAsset(name: "Card/warning")
  }
  public enum Chat {
    public static let comment = ImageAsset(name: "Chat/comment")
    public static let photo = ImageAsset(name: "Chat/photo")
  }
  public enum Currency {
    public static let britain = ImageAsset(name: "Currency/Britain")
    public static let china = ImageAsset(name: "Currency/China")
    public static let european = ImageAsset(name: "Currency/European")
    public static let usa = ImageAsset(name: "Currency/usa")
  }
  public enum Headers {
    public static let cardSample = ImageAsset(name: "Headers/cardSample")
    public static let lock = ImageAsset(name: "Headers/lock")
    public static let maserCardSample = ImageAsset(name: "Headers/maserCardSample")
    public static let visaSample = ImageAsset(name: "Headers/visaSample")
  }
  public enum IconTabs {
    public static let account = ImageAsset(name: "IconTabs/Account")
    public static let card = ImageAsset(name: "IconTabs/Card")
    public static let mobile = ImageAsset(name: "IconTabs/Mobile")
  }
  public enum Info {
    public static let emailSolid = ImageAsset(name: "Info/Email Solid")
    public static let helpSolid = ImageAsset(name: "Info/Help Solid")
    public static let infoSolid = ImageAsset(name: "Info/Info Solid")
    public static let info = ImageAsset(name: "Info/Info")
  }
  public enum LaunchScreen {
    public static let admiral = ImageAsset(name: "LaunchScreen/Admiral")
  }
  public enum Links {
    public static let arrowLeftBig = ImageAsset(name: "Links/arrowLeftBig")
    public static let arrowLeftSmall = ImageAsset(name: "Links/arrowLeftSmall")
    public static let arrowRightBig = ImageAsset(name: "Links/arrowRightBig")
    public static let arrowRightSmall = ImageAsset(name: "Links/arrowRightSmall")
  }
  public enum Main {
    public static let badges = ImageAsset(name: "Main/Badges")
    public static let bottomSheets = ImageAsset(name: "Main/BottomSheets")
    public static let calendar = ImageAsset(name: "Main/Calendar")
    public static let chat = ImageAsset(name: "Main/Chat")
    public static let checkboxes = ImageAsset(name: "Main/Checkboxes")
    public static let closeOutline = ImageAsset(name: "Main/Close Outline")
    public static let currency = ImageAsset(name: "Main/Currency")
    public static let draw = ImageAsset(name: "Main/Draw")
    public static let ellipse = ImageAsset(name: "Main/Ellipse")
    public static let envelope = ImageAsset(name: "Main/Envelope")
    public static let file = ImageAsset(name: "Main/File")
    public static let folder = ImageAsset(name: "Main/Folder")
    public static let gem = ImageAsset(name: "Main/Gem")
    public static let headers = ImageAsset(name: "Main/Headers")
    public static let links = ImageAsset(name: "Main/Links")
    public static let list = ImageAsset(name: "Main/List")
    public static let main = ImageAsset(name: "Main/Main")
    public static let pageControlls = ImageAsset(name: "Main/PageControlls")
    public static let pencil = ImageAsset(name: "Main/Pencil")
    public static let pin = ImageAsset(name: "Main/Pin")
    public static let plus = ImageAsset(name: "Main/Plus")
    public static let radiobuttons = ImageAsset(name: "Main/Radiobuttons")
    public static let refresh = ImageAsset(name: "Main/Refresh")
    public static let scheme = ImageAsset(name: "Main/Scheme")
    public static let spinner = ImageAsset(name: "Main/Spinner")
    public static let statusHIstory = ImageAsset(name: "Main/StatusHIstory")
    public static let textBlocks = ImageAsset(name: "Main/TextBlocks")
    public static let time = ImageAsset(name: "Main/Time")
    public static let pageControls = ImageAsset(name: "Main/pageControls")
  }
  public enum Navigation {
    public static let arrowLeft = ImageAsset(name: "Navigation/ArrowLeft")
  }
  public enum Onboarding {
    public static let one = ImageAsset(name: "Onboarding/One")
    public static let three = ImageAsset(name: "Onboarding/Three")
    public static let two = ImageAsset(name: "Onboarding/Two")
  }
  public enum Persons {
    public static let andrey = ImageAsset(name: "Persons/andrey")
  }
  public enum PinCode {
    public static let deleteButton = ImageAsset(name: "PinCode/deleteButton")
  }
  public enum PopUp {
    public static let popUpImage = ImageAsset(name: "PopUp/popUpImage")
  }
  public enum Settings {
    public static let chip = ImageAsset(name: "Settings/Chip")
    public static let settings = ImageAsset(name: "Settings/Settings")
  }
  public enum TabBar {
    public static let chat = ImageAsset(name: "TabBar/Chat")
    public static let info = ImageAsset(name: "TabBar/Info")
    public static let main = ImageAsset(name: "TabBar/Main")
    public static let settings = ImageAsset(name: "TabBar/Settings")
  }
  public enum Tabs {
    public static let masterCardLogo = ImageAsset(name: "Tabs/masterCardLogo")
    public static let mirLogo = ImageAsset(name: "Tabs/mirLogo")
    public static let visaLogo = ImageAsset(name: "Tabs/visaLogo")
  }
  public enum TagsChips {
    public static let carSolid = ImageAsset(name: "TagsChips/CarSolid")
    public static let russiaFlag = ImageAsset(name: "TagsChips/RussiaFlag")
  }
  public enum TextField {
    public static let cameraOutline = ImageAsset(name: "TextField/cameraOutline")
  }
  public enum Toolbar {
    public static let card = ImageAsset(name: "Toolbar/Card")
    public static let getCash = ImageAsset(name: "Toolbar/GetCash")
    public static let info = ImageAsset(name: "Toolbar/Info")
    public static let settings = ImageAsset(name: "Toolbar/Settings")
  }
  public enum Zeroscreen {
    public static let success = ImageAsset(name: "Zeroscreen/Success")
  }
  public static let arrowDown = ImageAsset(name: "arrowDown")
  public static let disclosure = ImageAsset(name: "disclosure")
  public static let disclosureDown = ImageAsset(name: "disclosureDown")
  public static let disclosureUp = ImageAsset(name: "disclosureUp")

  // swiftlint:disable trailing_comma
  @available(*, deprecated, message: "All values properties are now deprecated")
  public static let allImages: [ImageAsset] = [
    ActionBar.arrowDownOutline,
    ActionBar.arrowUpOutline,
    ActionBar.closeOutline,
    ActionBar.moreOutline,
    ActionBar.shape,
    ActionBar.union,
    ActionBar.mail,
    Badges.bonus,
    Badges.diamondSolid,
    Card.mir,
    Card.visa,
    Card.applePay,
    Card.appleWallet,
    Card.googlePay,
    Card.info,
    Card.rnb,
    Card.visaLabel,
    Card.warning,
    Chat.comment,
    Chat.photo,
    Currency.britain,
    Currency.china,
    Currency.european,
    Currency.usa,
    Headers.cardSample,
    Headers.lock,
    Headers.maserCardSample,
    Headers.visaSample,
    IconTabs.account,
    IconTabs.card,
    IconTabs.mobile,
    Info.emailSolid,
    Info.helpSolid,
    Info.infoSolid,
    Info.info,
    LaunchScreen.admiral,
    Links.arrowLeftBig,
    Links.arrowLeftSmall,
    Links.arrowRightBig,
    Links.arrowRightSmall,
    Main.badges,
    Main.bottomSheets,
    Main.calendar,
    Main.chat,
    Main.checkboxes,
    Main.closeOutline,
    Main.currency,
    Main.draw,
    Main.ellipse,
    Main.envelope,
    Main.file,
    Main.folder,
    Main.gem,
    Main.headers,
    Main.links,
    Main.list,
    Main.main,
    Main.pageControlls,
    Main.pencil,
    Main.pin,
    Main.plus,
    Main.radiobuttons,
    Main.refresh,
    Main.scheme,
    Main.spinner,
    Main.statusHIstory,
    Main.textBlocks,
    Main.time,
    Main.pageControls,
    Navigation.arrowLeft,
    Onboarding.one,
    Onboarding.three,
    Onboarding.two,
    Persons.andrey,
    PinCode.deleteButton,
    PopUp.popUpImage,
    Settings.chip,
    Settings.settings,
    TabBar.chat,
    TabBar.info,
    TabBar.main,
    TabBar.settings,
    Tabs.masterCardLogo,
    Tabs.mirLogo,
    Tabs.visaLogo,
    TagsChips.carSolid,
    TagsChips.russiaFlag,
    TextField.cameraOutline,
    Toolbar.card,
    Toolbar.getCash,
    Toolbar.info,
    Toolbar.settings,
    Zeroscreen.success,
    arrowDown,
    disclosure,
    disclosureDown,
    disclosureUp,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
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

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
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
