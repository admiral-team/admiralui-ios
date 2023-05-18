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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Documents {
    internal enum Outline {
      internal static let descriptionOutline = ImageAsset(name: "Documents/Outline/descriptionOutline")
    }
  }
  internal enum Location {
    internal enum Solid {
      internal static let gpsSolid = ImageAsset(name: "Location/Solid/gPSSolid")
    }
  }
  internal enum Security {
    internal enum Outline {
      internal static let faceIDOutline = ImageAsset(name: "Security/Outline/faceIDOutline")
    }
  }
  internal enum Service {
    internal enum Outline {
      internal static let checkClearOutline = ImageAsset(name: "Service/Outline/checkClearOutline")
      internal static let closeCircleOutline = ImageAsset(name: "Service/Outline/closeCircleOutline")
      internal static let closeOutline = ImageAsset(name: "Service/Outline/closeOutline")
      internal static let errorOutline = ImageAsset(name: "Service/Outline/errorOutline")
      internal static let eyeCloseOutline = ImageAsset(name: "Service/Outline/eyeCloseOutline")
      internal static let eyeOutline = ImageAsset(name: "Service/Outline/eyeOutline")
      internal static let helpOutline = ImageAsset(name: "Service/Outline/helpOutline")
      internal static let infoOutline = ImageAsset(name: "Service/Outline/infoOutline")
      internal static let minusOutline = ImageAsset(name: "Service/Outline/minusOutline")
      internal static let plusOutline = ImageAsset(name: "Service/Outline/plusOutline")
    }
    internal enum Solid {
      internal static let checkSolid = ImageAsset(name: "Service/Solid/checkSolid")
      internal static let closeSolid = ImageAsset(name: "Service/Solid/closeSolid")
      internal static let dragSolid = ImageAsset(name: "Service/Solid/dragSolid")
      internal static let errorSolid = ImageAsset(name: "Service/Solid/errorSolid")
      internal static let errorTriangleSolid = ImageAsset(name: "Service/Solid/errorTriangleSolid")
      internal static let helpSolid = ImageAsset(name: "Service/Solid/helpSolid")
      internal static let infoSolid = ImageAsset(name: "Service/Solid/infoSolid")
    }
  }
  internal enum System {
    internal enum Outline {
      internal static let arrowDownOutline = ImageAsset(name: "System/Outline/arrowDownOutline")
      internal static let arrowLeftOutline = ImageAsset(name: "System/Outline/arrowLeftOutline")
      internal static let arrowRightOutline = ImageAsset(name: "System/Outline/arrowRightOutline")
      internal static let arrowUpOutline = ImageAsset(name: "System/Outline/arrowUpOutline")
      internal static let attachFileOutline = ImageAsset(name: "System/Outline/attachFileOutline")
      internal static let checkBoxOff = ImageAsset(name: "System/Outline/checkBoxOff")
      internal static let chevronDownOutline = ImageAsset(name: "System/Outline/chevronDownOutline")
      internal static let chevronLeftOutline = ImageAsset(name: "System/Outline/chevronLeftOutline")
      internal static let chevronRightOutline = ImageAsset(name: "System/Outline/chevronRightOutline")
      internal static let chevronUpOutline = ImageAsset(name: "System/Outline/chevronUpOutline")
      internal static let deleteOutline = ImageAsset(name: "System/Outline/deleteOutline")
      internal static let radioButtonOff = ImageAsset(name: "System/Outline/radioButtonOff")
      internal static let read = ImageAsset(name: "System/Outline/read")
      internal static let searchOutline = ImageAsset(name: "System/Outline/searchOutline")
      internal static let sent = ImageAsset(name: "System/Outline/sent")
      internal static let timeOutline = ImageAsset(name: "System/Outline/timeOutline")
    }
    internal enum Solid {
      internal static let checkBoxOn = ImageAsset(name: "System/Solid/checkBoxOn")
      internal static let point = ImageAsset(name: "System/Solid/point")
      internal static let radioButtonOn = ImageAsset(name: "System/Solid/radioButtonOn")
      internal static let starSolid = ImageAsset(name: "System/Solid/starSolid")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
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
}

internal extension ImageAsset.Image {
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
