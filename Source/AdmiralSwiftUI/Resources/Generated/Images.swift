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
@available(*, deprecated, renamed: "ImagesNewAssetImage.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias ImagesNewAssetImageType = ImagesNewAssetImage.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum ImagesNew {
  internal enum Category {
    internal enum Outline {
      internal static let acceptOutline = ImagesNewAssetImage(name: "Category/Outline/acceptOutline")
      internal static let addCommentOutline = ImagesNewAssetImage(name: "Category/Outline/addCommentOutline")
      internal static let bankOutline = ImagesNewAssetImage(name: "Category/Outline/bankOutline")
    }
  }
  internal enum Documents {
    internal enum Outline {
      internal static let descriptionOutline = ImagesNewAssetImage(name: "Documents/Outline/descriptionOutline")
    }
    internal enum Solid {
      internal static let accountDetailSolid = ImagesNewAssetImage(name: "Documents/Solid/accountDetailSolid")
    }
  }
  internal enum Service {
    internal enum Outline {
      internal static let closeOutline = ImagesNewAssetImage(name: "Service/Outline/closeOutline")
      internal static let minusOutline = ImagesNewAssetImage(name: "Service/Outline/minusOutline")
      internal static let plusOutline = ImagesNewAssetImage(name: "Service/Outline/plusOutline")
    }
    internal enum Solid {
      internal static let closeSolid = ImagesNewAssetImage(name: "Service/Solid/closeSolid")
      internal static let errorSolid = ImagesNewAssetImage(name: "Service/Solid/errorSolid")
    }
  }
  internal enum System {
    internal enum Outline {
      internal static let arrowDownOutline = ImagesNewAssetImage(name: "System/Outline/arrowDownOutline")
      internal static let arrowLeftOutline = ImagesNewAssetImage(name: "System/Outline/arrowLeftOutline")
      internal static let arrowRightOutline = ImagesNewAssetImage(name: "System/Outline/arrowRightOutline")
      internal static let chevronDownOutline = ImagesNewAssetImage(name: "System/Outline/chevronDownOutline")
      internal static let chevronRightOutline = ImagesNewAssetImage(name: "System/Outline/chevronRightOutline")
      internal static let chevronUpOutline = ImagesNewAssetImage(name: "System/Outline/chevronUpOutline")
    }
    internal enum Solid {
      internal static let starSolid = ImagesNewAssetImage(name: "System/Solid/starSolid")
    }
  }

  // swiftlint:disable trailing_comma
  @available(*, deprecated, message: "All values properties are now deprecated")
  internal static let allImages: [ImagesNewAssetImage] = [
    Category.Outline.acceptOutline,
    Category.Outline.addCommentOutline,
    Category.Outline.bankOutline,
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

internal struct ImagesNewAssetImage {
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

internal extension ImagesNewAssetImage.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImagesNewAssetImage.image property")
  convenience init?(asset: ImagesNewAssetImage) {
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
  init(asset: ImagesNewAssetImage) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImagesNewAssetImage, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImagesNewAssetImage) {
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
