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
@available(*, deprecated, renamed: "IAImage.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias IAImageType = IAImage.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum ImageAssets {
  internal enum Category {
    internal enum Outline {
      internal static let acceptOutline = IAImage(name: "Category/Outline/acceptOutline")
      internal static let addCommentOutline = IAImage(name: "Category/Outline/addCommentOutline")
      internal static let bankOutline = IAImage(name: "Category/Outline/bankOutline")
    }
  }
  internal enum Custom {
    internal enum Cell {
      internal static let point = IAImage(name: "Custom/Cell/point")
    }
    internal enum Chat {
      internal static let read = IAImage(name: "Custom/Chat/Read")
      internal static let sent = IAImage(name: "Custom/Chat/Sent")
    }
    internal enum Control {
      internal static let checkBoxOff = IAImage(name: "Custom/Control/checkBoxOff")
      internal static let checkBoxOn = IAImage(name: "Custom/Control/checkBoxOn")
      internal static let radioButtonOff = IAImage(name: "Custom/Control/radioButtonOff")
      internal static let radioButtonOn = IAImage(name: "Custom/Control/radioButtonOn")
    }
    internal enum Informers {
      internal static let question = IAImage(name: "Custom/Informers/question")
    }
    internal enum Segment {
      internal static let arrowDown = IAImage(name: "Custom/Segment/arrowDown")
      internal static let arrowUp = IAImage(name: "Custom/Segment/arrowUp")
    }
  }
  internal enum Documents {
    internal enum Outline {
      internal static let descriptionOutline = IAImage(name: "Documents/Outline/descriptionOutline")
    }
    internal enum Solid {
      internal static let accountDetailSolid = IAImage(name: "Documents/Solid/accountDetailSolid")
    }
  }
  internal enum Service {
    internal enum Outline {
      internal static let closeOutline = IAImage(name: "Service/Outline/closeOutline")
      internal static let minusOutline = IAImage(name: "Service/Outline/minusOutline")
      internal static let plusOutline = IAImage(name: "Service/Outline/plusOutline")
    }
    internal enum Solid {
      internal static let closeSolid = IAImage(name: "Service/Solid/closeSolid")
      internal static let errorSolid = IAImage(name: "Service/Solid/errorSolid")
    }
  }
  internal enum System {
    internal enum Outline {
      internal static let arrowDownOutline = IAImage(name: "System/Outline/arrowDownOutline")
      internal static let arrowLeftOutline = IAImage(name: "System/Outline/arrowLeftOutline")
      internal static let arrowRightOutline = IAImage(name: "System/Outline/arrowRightOutline")
      internal static let chevronDownOutline = IAImage(name: "System/Outline/chevronDownOutline")
      internal static let chevronRightOutline = IAImage(name: "System/Outline/chevronRightOutline")
      internal static let chevronUpOutline = IAImage(name: "System/Outline/chevronUpOutline")
    }
    internal enum Solid {
      internal static let starSolid = IAImage(name: "System/Solid/starSolid")
    }
  }

  // swiftlint:disable trailing_comma
  internal static let allImages: [IAImage] = [
    Category.Outline.acceptOutline,
    Category.Outline.addCommentOutline,
    Category.Outline.bankOutline,
    Custom.Cell.point,
    Custom.Chat.read,
    Custom.Chat.sent,
    Custom.Control.checkBoxOff,
    Custom.Control.checkBoxOn,
    Custom.Control.radioButtonOff,
    Custom.Control.radioButtonOn,
    Custom.Informers.question,
    Custom.Segment.arrowDown,
    Custom.Segment.arrowUp,
    Documents.Outline.descriptionOutline,
    Documents.Solid.accountDetailSolid,
    Service.Outline.closeOutline,
    Service.Outline.minusOutline,
    Service.Outline.plusOutline,
    Service.Solid.closeSolid,
    Service.Solid.errorSolid,
    System.Outline.arrowDownOutline,
    System.Outline.arrowLeftOutline,
    System.Outline.arrowRightOutline,
    System.Outline.chevronDownOutline,
    System.Outline.chevronRightOutline,
    System.Outline.chevronUpOutline,
    System.Solid.starSolid,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct IAImage {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
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
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension IAImage.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the IAImage.image property")
  convenience init?(asset: IAImage) {
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
internal extension SwiftUI.Image {
  init(asset: IAImage) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: IAImage, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: IAImage) {
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
