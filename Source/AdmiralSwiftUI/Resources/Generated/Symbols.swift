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
internal enum SymbolsNew {
  internal enum Category {
    internal enum Outline {
      internal static let acuringFuture = SymbolAsset(name: "Category/Outline/acuringFuture")
      internal static let acuringModern = SymbolAsset(name: "Category/Outline/acuringModern")
    }
  }
  internal enum Location {
    internal enum Solid {
      internal static let gps = SymbolAsset(name: "Location/Solid/gPS")
    }
  }
  internal enum Security {
    internal enum Outline {
      internal static let faceID = SymbolAsset(name: "Security/Outline/faceID")
    }
  }
  internal enum Service {
    internal enum Outline {
      internal static let checkClear = SymbolAsset(name: "Service/Outline/checkClear")
      internal static let close = SymbolAsset(name: "Service/Outline/close")
      internal static let closeCircle = SymbolAsset(name: "Service/Outline/closeCircle")
      internal static let eye = SymbolAsset(name: "Service/Outline/eye")
      internal static let eyeClose = SymbolAsset(name: "Service/Outline/eyeClose")
    }
    internal enum Solid {
      internal static let check = SymbolAsset(name: "Service/Solid/check")
      internal static let error = SymbolAsset(name: "Service/Solid/error")
      internal static let errorTriangle = SymbolAsset(name: "Service/Solid/errorTriangle")
      internal static let info = SymbolAsset(name: "Service/Solid/info")
    }
  }
  internal enum System {
    internal enum Outline {
      internal static let arrowDown = SymbolAsset(name: "System/Outline/arrowDown")
      internal static let arrowRight = SymbolAsset(name: "System/Outline/arrowRight")
      internal static let arrowUp = SymbolAsset(name: "System/Outline/arrowUp")
      internal static let attachFile = SymbolAsset(name: "System/Outline/attachFile")
      internal static let chevronLeft = SymbolAsset(name: "System/Outline/chevronLeft")
      internal static let chevronRight = SymbolAsset(name: "System/Outline/chevronRight")
      internal static let search = SymbolAsset(name: "System/Outline/search")
      internal static let smallArrowUp = SymbolAsset(name: "System/Outline/smallArrowUp")
      internal static let time = SymbolAsset(name: "System/Outline/time")
    }
  }

  // swiftlint:disable trailing_comma
  @available(*, deprecated, message: "All values properties are now deprecated")
  internal static let allSymbols: [SymbolAsset] = [
    Category.Outline.acuringFuture,
    Category.Outline.acuringModern,
    Location.Solid.gps,
    Security.Outline.faceID,
    Service.Outline.checkClear,
    Service.Outline.close,
    Service.Outline.closeCircle,
    Service.Outline.eye,
    Service.Outline.eyeClose,
    Service.Solid.check,
    Service.Solid.error,
    Service.Solid.errorTriangle,
    Service.Solid.info,
    System.Outline.arrowDown,
    System.Outline.arrowRight,
    System.Outline.arrowUp,
    System.Outline.attachFile,
    System.Outline.chevronLeft,
    System.Outline.chevronRight,
    System.Outline.search,
    System.Outline.smallArrowUp,
    System.Outline.time,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct SymbolAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(watchOS)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  internal typealias Configuration = UIImage.SymbolConfiguration
  internal typealias Image = UIImage

  @available(iOS 12.0, tvOS 12.0, watchOS 5.0, *)
  internal var image: Image {
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
  internal func image(with configuration: Configuration) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, with: configuration) else {
      fatalError("Unable to load symbol asset named \(name).")
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

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
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
