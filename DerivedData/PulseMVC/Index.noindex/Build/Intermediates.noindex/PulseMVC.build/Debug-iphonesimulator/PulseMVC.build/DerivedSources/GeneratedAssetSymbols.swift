import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "EmptyRectangle" asset catalog image resource.
    static let emptyRectangle = DeveloperToolsSupport.ImageResource(name: "EmptyRectangle", bundle: resourceBundle)

    /// The "FullRectangle" asset catalog image resource.
    static let fullRectangle = DeveloperToolsSupport.ImageResource(name: "FullRectangle", bundle: resourceBundle)

    /// The "RectangleWitchoutBorder" asset catalog image resource.
    static let rectangleWitchoutBorder = DeveloperToolsSupport.ImageResource(name: "RectangleWitchoutBorder", bundle: resourceBundle)

    /// The "RectangleWithBorder" asset catalog image resource.
    static let rectangleWithBorder = DeveloperToolsSupport.ImageResource(name: "RectangleWithBorder", bundle: resourceBundle)

    /// The "active" asset catalog image resource.
    static let active = DeveloperToolsSupport.ImageResource(name: "active", bundle: resourceBundle)

    /// The "add" asset catalog image resource.
    static let add = DeveloperToolsSupport.ImageResource(name: "add", bundle: resourceBundle)

    /// The "backgroundColor" asset catalog image resource.
    static let background = DeveloperToolsSupport.ImageResource(name: "backgroundColor", bundle: resourceBundle)

    /// The "coffee" asset catalog image resource.
    static let coffee = DeveloperToolsSupport.ImageResource(name: "coffee", bundle: resourceBundle)

    /// The "crookedLine" asset catalog image resource.
    static let crookedLine = DeveloperToolsSupport.ImageResource(name: "crookedLine", bundle: resourceBundle)

    /// The "cursor" asset catalog image resource.
    static let cursor = DeveloperToolsSupport.ImageResource(name: "cursor", bundle: resourceBundle)

    /// The "diet_icon" asset catalog image resource.
    static let dietIcon = DeveloperToolsSupport.ImageResource(name: "diet_icon", bundle: resourceBundle)

    /// The "emptyCheckBox" asset catalog image resource.
    static let emptyCheckBox = DeveloperToolsSupport.ImageResource(name: "emptyCheckBox", bundle: resourceBundle)

    /// The "fullCheckBox" asset catalog image resource.
    static let fullCheckBox = DeveloperToolsSupport.ImageResource(name: "fullCheckBox", bundle: resourceBundle)

    /// The "fullHeart" asset catalog image resource.
    static let fullHeart = DeveloperToolsSupport.ImageResource(name: "fullHeart", bundle: resourceBundle)

    /// The "history_icon" asset catalog image resource.
    static let historyIcon = DeveloperToolsSupport.ImageResource(name: "history_icon", bundle: resourceBundle)

    /// The "infoButton" asset catalog image resource.
    static let infoButton = DeveloperToolsSupport.ImageResource(name: "infoButton", bundle: resourceBundle)

    /// The "pulse_icon" asset catalog image resource.
    static let pulseIcon = DeveloperToolsSupport.ImageResource(name: "pulse_icon", bundle: resourceBundle)

    /// The "purpleHeart" asset catalog image resource.
    static let purpleHeart = DeveloperToolsSupport.ImageResource(name: "purpleHeart", bundle: resourceBundle)

    /// The "redAdd" asset catalog image resource.
    static let redAdd = DeveloperToolsSupport.ImageResource(name: "redAdd", bundle: resourceBundle)

    /// The "scheduleLine" asset catalog image resource.
    static let scheduleLine = DeveloperToolsSupport.ImageResource(name: "scheduleLine", bundle: resourceBundle)

    /// The "sleep" asset catalog image resource.
    static let sleep = DeveloperToolsSupport.ImageResource(name: "sleep", bundle: resourceBundle)

    /// The "test_icon" asset catalog image resource.
    static let testIcon = DeveloperToolsSupport.ImageResource(name: "test_icon", bundle: resourceBundle)

    #warning("The \"test_icon \" image asset name resolves to the symbol \"testIcon\" which already exists. Try renaming the asset.")

    /// The "tutorial" asset catalog image resource.
    static let tutorial = DeveloperToolsSupport.ImageResource(name: "tutorial", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "EmptyRectangle" asset catalog image.
    static var emptyRectangle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emptyRectangle)
#else
        .init()
#endif
    }

    /// The "FullRectangle" asset catalog image.
    static var fullRectangle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fullRectangle)
#else
        .init()
#endif
    }

    /// The "RectangleWitchoutBorder" asset catalog image.
    static var rectangleWitchoutBorder: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rectangleWitchoutBorder)
#else
        .init()
#endif
    }

    /// The "RectangleWithBorder" asset catalog image.
    static var rectangleWithBorder: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rectangleWithBorder)
#else
        .init()
#endif
    }

    /// The "active" asset catalog image.
    static var active: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .active)
#else
        .init()
#endif
    }

    /// The "add" asset catalog image.
    static var add: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .add)
#else
        .init()
#endif
    }

    /// The "backgroundColor" asset catalog image.
    static var background: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .background)
#else
        .init()
#endif
    }

    /// The "coffee" asset catalog image.
    static var coffee: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .coffee)
#else
        .init()
#endif
    }

    /// The "crookedLine" asset catalog image.
    static var crookedLine: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .crookedLine)
#else
        .init()
#endif
    }

    /// The "cursor" asset catalog image.
    static var cursor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cursor)
#else
        .init()
#endif
    }

    /// The "diet_icon" asset catalog image.
    static var dietIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dietIcon)
#else
        .init()
#endif
    }

    /// The "emptyCheckBox" asset catalog image.
    static var emptyCheckBox: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emptyCheckBox)
#else
        .init()
#endif
    }

    /// The "fullCheckBox" asset catalog image.
    static var fullCheckBox: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fullCheckBox)
#else
        .init()
#endif
    }

    /// The "fullHeart" asset catalog image.
    static var fullHeart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fullHeart)
#else
        .init()
#endif
    }

    /// The "history_icon" asset catalog image.
    static var historyIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .historyIcon)
#else
        .init()
#endif
    }

    /// The "infoButton" asset catalog image.
    static var infoButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .infoButton)
#else
        .init()
#endif
    }

    /// The "pulse_icon" asset catalog image.
    static var pulseIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pulseIcon)
#else
        .init()
#endif
    }

    /// The "purpleHeart" asset catalog image.
    static var purpleHeart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .purpleHeart)
#else
        .init()
#endif
    }

    /// The "redAdd" asset catalog image.
    static var redAdd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .redAdd)
#else
        .init()
#endif
    }

    /// The "scheduleLine" asset catalog image.
    static var scheduleLine: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scheduleLine)
#else
        .init()
#endif
    }

    /// The "sleep" asset catalog image.
    static var sleep: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sleep)
#else
        .init()
#endif
    }

    /// The "test_icon" asset catalog image.
    static var testIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .testIcon)
#else
        .init()
#endif
    }

    /// The "tutorial" asset catalog image.
    static var tutorial: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tutorial)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "EmptyRectangle" asset catalog image.
    static var emptyRectangle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emptyRectangle)
#else
        .init()
#endif
    }

    /// The "FullRectangle" asset catalog image.
    static var fullRectangle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fullRectangle)
#else
        .init()
#endif
    }

    /// The "RectangleWitchoutBorder" asset catalog image.
    static var rectangleWitchoutBorder: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rectangleWitchoutBorder)
#else
        .init()
#endif
    }

    /// The "RectangleWithBorder" asset catalog image.
    static var rectangleWithBorder: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rectangleWithBorder)
#else
        .init()
#endif
    }

    /// The "active" asset catalog image.
    static var active: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .active)
#else
        .init()
#endif
    }

    #warning("The \"add\" image asset name resolves to a conflicting UIImage symbol \"add\". Try renaming the asset.")

    /// The "backgroundColor" asset catalog image.
    static var background: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .background)
#else
        .init()
#endif
    }

    /// The "coffee" asset catalog image.
    static var coffee: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .coffee)
#else
        .init()
#endif
    }

    /// The "crookedLine" asset catalog image.
    static var crookedLine: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .crookedLine)
#else
        .init()
#endif
    }

    /// The "cursor" asset catalog image.
    static var cursor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cursor)
#else
        .init()
#endif
    }

    /// The "diet_icon" asset catalog image.
    static var dietIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dietIcon)
#else
        .init()
#endif
    }

    /// The "emptyCheckBox" asset catalog image.
    static var emptyCheckBox: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emptyCheckBox)
#else
        .init()
#endif
    }

    /// The "fullCheckBox" asset catalog image.
    static var fullCheckBox: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fullCheckBox)
#else
        .init()
#endif
    }

    /// The "fullHeart" asset catalog image.
    static var fullHeart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fullHeart)
#else
        .init()
#endif
    }

    /// The "history_icon" asset catalog image.
    static var historyIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .historyIcon)
#else
        .init()
#endif
    }

    /// The "infoButton" asset catalog image.
    static var infoButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .infoButton)
#else
        .init()
#endif
    }

    /// The "pulse_icon" asset catalog image.
    static var pulseIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pulseIcon)
#else
        .init()
#endif
    }

    /// The "purpleHeart" asset catalog image.
    static var purpleHeart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .purpleHeart)
#else
        .init()
#endif
    }

    /// The "redAdd" asset catalog image.
    static var redAdd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .redAdd)
#else
        .init()
#endif
    }

    /// The "scheduleLine" asset catalog image.
    static var scheduleLine: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scheduleLine)
#else
        .init()
#endif
    }

    /// The "sleep" asset catalog image.
    static var sleep: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sleep)
#else
        .init()
#endif
    }

    /// The "test_icon" asset catalog image.
    static var testIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .testIcon)
#else
        .init()
#endif
    }

    /// The "tutorial" asset catalog image.
    static var tutorial: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tutorial)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

