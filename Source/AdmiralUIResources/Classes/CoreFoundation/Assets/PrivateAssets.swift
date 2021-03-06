// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "PrivateImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias PrivateAssetImageTypeAlias = PrivateImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum PrivateAsset {
  public enum Custom {
    public enum BottomSheet {
      public static let close = PrivateImageAsset(name: "Custom/BottomSheet/close")
    }
    public enum Cell {
      public static let arrow = PrivateImageAsset(name: "Custom/Cell/arrow")
      public static let arrowDown = PrivateImageAsset(name: "Custom/Cell/arrowDown")
      public static let arrowUp = PrivateImageAsset(name: "Custom/Cell/arrowUp")
      public static let point = PrivateImageAsset(name: "Custom/Cell/point")
    }
    public enum Chat {
      public static let photo = PrivateImageAsset(name: "Custom/Chat/Photo")
      public static let read = PrivateImageAsset(name: "Custom/Chat/Read")
      public static let sent = PrivateImageAsset(name: "Custom/Chat/Sent")
      public static let error = PrivateImageAsset(name: "Custom/Chat/Shape")
    }
    public enum CirclePageControl {
      public static let arrowRight = PrivateImageAsset(name: "Custom/CirclePageControl/arrowRight")
    }
    public enum Control {
      public static let checkBoxOff = PrivateImageAsset(name: "Custom/Control/checkBoxOff")
      public static let checkBoxOn = PrivateImageAsset(name: "Custom/Control/checkBoxOn")
      public static let radioButtonOff = PrivateImageAsset(name: "Custom/Control/radioButtonOff")
      public static let radioButtonOn = PrivateImageAsset(name: "Custom/Control/radioButtonOn")
    }
    public enum Informers {
      public static let question = PrivateImageAsset(name: "Custom/Informers/question")
    }
    public enum Segment {
      public static let arrowDown = PrivateImageAsset(name: "Custom/Segment/arrowDown")
      public static let arrowUp = PrivateImageAsset(name: "Custom/Segment/arrowUp")
    }
  }

  // swiftlint:disable trailing_comma
  public static let allImages: [PrivateImageAsset] = [
    Custom.BottomSheet.close,
    Custom.Cell.arrow,
    Custom.Cell.arrowDown,
    Custom.Cell.arrowUp,
    Custom.Cell.point,
    Custom.Chat.photo,
    Custom.Chat.read,
    Custom.Chat.sent,
    Custom.Chat.error,
    Custom.CirclePageControl.arrowRight,
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

public struct PrivateImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

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
}

public extension PrivateImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the PrivateImageAsset.image property")
  convenience init?(asset: PrivateImageAsset) {
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
