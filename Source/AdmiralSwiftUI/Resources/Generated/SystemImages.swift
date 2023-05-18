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
@available(*, deprecated, renamed: "SIAImage.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias SIAImageType = SIAImage.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum SystemImageAssets {
  internal enum Custom {
    internal enum Cell {
      internal static let point = SIAImage(name: "Custom/Cell/point")
    }
    internal enum Chat {
      internal static let read = SIAImage(name: "Custom/Chat/Read")
      internal static let sent = SIAImage(name: "Custom/Chat/Sent")
    }
    internal enum Control {
      internal static let checkBoxOff = SIAImage(name: "Custom/Control/checkBoxOff")
      internal static let checkBoxOn = SIAImage(name: "Custom/Control/checkBoxOn")
      internal static let radioButtonOff = SIAImage(name: "Custom/Control/radioButtonOff")
      internal static let radioButtonOn = SIAImage(name: "Custom/Control/radioButtonOn")
    }
    internal enum Informers {
      internal static let question = SIAImage(name: "Custom/Informers/question")
    }
    internal enum Segment {
      internal static let arrowDown = SIAImage(name: "Custom/Segment/arrowDown")
      internal static let arrowUp = SIAImage(name: "Custom/Segment/arrowUp")
    }
  }

  // swiftlint:disable trailing_comma
  @available(*, deprecated, message: "All values properties are now deprecated")
  internal static let allImages: [SIAImage] = [
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
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct SIAImage {
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

internal extension SIAImage.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the SIAImage.image property")
  convenience init?(asset: SIAImage) {
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
  init(asset: SIAImage) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: SIAImage, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: SIAImage) {
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
