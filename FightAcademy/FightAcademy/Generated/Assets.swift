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
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let aboutimage = ImageAsset(name: "aboutimage")
    internal static let aboutimage2 = ImageAsset(name: "aboutimage2")
    internal static let facebook = ImageAsset(name: "facebook")
    internal static let instagram = ImageAsset(name: "instagram")
    internal static let youtube = ImageAsset(name: "youtube")
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal static let eye = ImageAsset(name: "eye")
    internal static let lock = ImageAsset(name: "lock")
    internal static let logo = ImageAsset(name: "logo")
    internal static let mail = ImageAsset(name: "mail")
    internal static let phone = ImageAsset(name: "phone")
    internal static let visibility = ImageAsset(name: "visibility")
    internal static let language = ImageAsset(name: "language")
    internal static let notification = ImageAsset(name: "notification")
    internal static let personalization = ImageAsset(name: "personalization")
    internal static let activity = ImageAsset(name: "activity")
    internal static let coaches = ImageAsset(name: "coaches")
    internal static let history = ImageAsset(name: "history")
    internal static let main = ImageAsset(name: "main")
    internal static let settings = ImageAsset(name: "settings")
    internal static let buttonShowMore = ImageAsset(name: "buttonShowMore")
    internal static let chevronLeft = ImageAsset(name: "chevron_left")
    internal static let dambbell = ImageAsset(name: "dambbell")
    internal static let error = ImageAsset(name: "error")
    internal static let logoLaunch = ImageAsset(name: "logoLaunch")
    internal static let plus = ImageAsset(name: "plus")
    internal static let testAvatarImage = ImageAsset(name: "testAvatarImage")
  }
  internal enum Colors {
    internal static let backgroundColor = ColorAsset(name: "backgroundColor")
    internal static let clearButtonColor = ColorAsset(name: "clearButtonColor")
    internal static let customGray = ColorAsset(name: "customGray")
    internal static let customWhite = ColorAsset(name: "customWhite")
    internal static let customYellow = ColorAsset(name: "customYellow")
    internal static let errorTextCollor = ColorAsset(name: "errorTextCollor")
    internal static let typingTextColor = ColorAsset(name: "typingTextColor")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

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
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
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
