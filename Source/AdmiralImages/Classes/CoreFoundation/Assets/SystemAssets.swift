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
@available(*, deprecated, renamed: "SystemImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias SystemAssetImageTypeAlias = SystemImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum SystemAsset {
  public enum Cell {
    public static let point = SystemImageAsset(name: "Cell/point")
  }
  public enum Chat {
    public static let read = SystemImageAsset(name: "Chat/Read")
    public static let sent = SystemImageAsset(name: "Chat/Sent")
  }
  public enum CirclePageControl {
    public static let arrowRight = SystemImageAsset(name: "CirclePageControl/arrowRight")
  }
  public enum Control {
    public static let checkBoxOff = SystemImageAsset(name: "Control/checkBoxOff")
    public static let checkBoxOn = SystemImageAsset(name: "Control/checkBoxOn")
    public static let radioButtonOff = SystemImageAsset(name: "Control/radioButtonOff")
    public static let radioButtonOn = SystemImageAsset(name: "Control/radioButtonOn")
  }
  public enum Informers {
    public static let question = SystemImageAsset(name: "Informers/question")
  }
  public enum Segment {
    public static let arrowDown = SystemImageAsset(name: "Segment/arrowDown")
    public static let arrowUp = SystemImageAsset(name: "Segment/arrowUp")
  }

  // swiftlint:disable trailing_comma
  public static let allImages: [SystemImageAsset] = [
    Cell.point,
    Chat.read,
    Chat.sent,
    CirclePageControl.arrowRight,
    Control.checkBoxOff,
    Control.checkBoxOn,
    Control.radioButtonOff,
    Control.radioButtonOn,
    Informers.question,
    Segment.arrowDown,
    Segment.arrowUp,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct SystemImageAsset {
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

public extension SystemImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the SystemImageAsset.image property")
  convenience init?(asset: SystemImageAsset) {
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
  init(asset: SystemImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: SystemImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: SystemImageAsset) {
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