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

    /// The "Background 1" asset catalog image resource.
    static let background1 = DeveloperToolsSupport.ImageResource(name: "Background 1", bundle: resourceBundle)

    /// The "Background 2" asset catalog image resource.
    static let background2 = DeveloperToolsSupport.ImageResource(name: "Background 2", bundle: resourceBundle)

    /// The "Background 3" asset catalog image resource.
    static let background3 = DeveloperToolsSupport.ImageResource(name: "Background 3", bundle: resourceBundle)

    /// The "Journal 1" asset catalog image resource.
    static let journal1 = DeveloperToolsSupport.ImageResource(name: "Journal 1", bundle: resourceBundle)

    /// The "Journal 2" asset catalog image resource.
    static let journal2 = DeveloperToolsSupport.ImageResource(name: "Journal 2", bundle: resourceBundle)

    /// The "Journal 3" asset catalog image resource.
    static let journal3 = DeveloperToolsSupport.ImageResource(name: "Journal 3", bundle: resourceBundle)

    /// The "Playful" asset catalog image resource.
    static let playful = DeveloperToolsSupport.ImageResource(name: "Playful", bundle: resourceBundle)

    /// The "Playful recap" asset catalog image resource.
    static let playfulRecap = DeveloperToolsSupport.ImageResource(name: "Playful recap", bundle: resourceBundle)

    /// The "PopUp" asset catalog image resource.
    static let popUp = DeveloperToolsSupport.ImageResource(name: "PopUp", bundle: resourceBundle)

    /// The "PopUp Streak" asset catalog image resource.
    static let popUpStreak = DeveloperToolsSupport.ImageResource(name: "PopUp Streak", bundle: resourceBundle)

    /// The "Post it" asset catalog image resource.
    static let postIt = DeveloperToolsSupport.ImageResource(name: "Post it", bundle: resourceBundle)

    /// The "Progress" asset catalog image resource.
    static let progress = DeveloperToolsSupport.ImageResource(name: "Progress", bundle: resourceBundle)

    /// The "Quiet" asset catalog image resource.
    static let quiet = DeveloperToolsSupport.ImageResource(name: "Quiet", bundle: resourceBundle)

    /// The "Sleepy" asset catalog image resource.
    static let sleepy = DeveloperToolsSupport.ImageResource(name: "Sleepy", bundle: resourceBundle)

    /// The "Weekly HT" asset catalog image resource.
    static let weeklyHT = DeveloperToolsSupport.ImageResource(name: "Weekly HT", bundle: resourceBundle)

    /// The "Wild" asset catalog image resource.
    static let wild = DeveloperToolsSupport.ImageResource(name: "Wild", bundle: resourceBundle)

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

    /// The "Background 1" asset catalog image.
    static var background1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .background1)
#else
        .init()
#endif
    }

    /// The "Background 2" asset catalog image.
    static var background2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .background2)
#else
        .init()
#endif
    }

    /// The "Background 3" asset catalog image.
    static var background3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .background3)
#else
        .init()
#endif
    }

    /// The "Journal 1" asset catalog image.
    static var journal1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .journal1)
#else
        .init()
#endif
    }

    /// The "Journal 2" asset catalog image.
    static var journal2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .journal2)
#else
        .init()
#endif
    }

    /// The "Journal 3" asset catalog image.
    static var journal3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .journal3)
#else
        .init()
#endif
    }

    /// The "Playful" asset catalog image.
    static var playful: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playful)
#else
        .init()
#endif
    }

    /// The "Playful recap" asset catalog image.
    static var playfulRecap: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playfulRecap)
#else
        .init()
#endif
    }

    /// The "PopUp" asset catalog image.
    static var popUp: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .popUp)
#else
        .init()
#endif
    }

    /// The "PopUp Streak" asset catalog image.
    static var popUpStreak: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .popUpStreak)
#else
        .init()
#endif
    }

    /// The "Post it" asset catalog image.
    static var postIt: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .postIt)
#else
        .init()
#endif
    }

    /// The "Progress" asset catalog image.
    static var progress: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .progress)
#else
        .init()
#endif
    }

    /// The "Quiet" asset catalog image.
    static var quiet: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .quiet)
#else
        .init()
#endif
    }

    /// The "Sleepy" asset catalog image.
    static var sleepy: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sleepy)
#else
        .init()
#endif
    }

    /// The "Weekly HT" asset catalog image.
    static var weeklyHT: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .weeklyHT)
#else
        .init()
#endif
    }

    /// The "Wild" asset catalog image.
    static var wild: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wild)
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

    /// The "Background 1" asset catalog image.
    static var background1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .background1)
#else
        .init()
#endif
    }

    /// The "Background 2" asset catalog image.
    static var background2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .background2)
#else
        .init()
#endif
    }

    /// The "Background 3" asset catalog image.
    static var background3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .background3)
#else
        .init()
#endif
    }

    /// The "Journal 1" asset catalog image.
    static var journal1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .journal1)
#else
        .init()
#endif
    }

    /// The "Journal 2" asset catalog image.
    static var journal2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .journal2)
#else
        .init()
#endif
    }

    /// The "Journal 3" asset catalog image.
    static var journal3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .journal3)
#else
        .init()
#endif
    }

    /// The "Playful" asset catalog image.
    static var playful: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playful)
#else
        .init()
#endif
    }

    /// The "Playful recap" asset catalog image.
    static var playfulRecap: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playfulRecap)
#else
        .init()
#endif
    }

    /// The "PopUp" asset catalog image.
    static var popUp: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .popUp)
#else
        .init()
#endif
    }

    /// The "PopUp Streak" asset catalog image.
    static var popUpStreak: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .popUpStreak)
#else
        .init()
#endif
    }

    /// The "Post it" asset catalog image.
    static var postIt: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .postIt)
#else
        .init()
#endif
    }

    /// The "Progress" asset catalog image.
    static var progress: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .progress)
#else
        .init()
#endif
    }

    /// The "Quiet" asset catalog image.
    static var quiet: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .quiet)
#else
        .init()
#endif
    }

    /// The "Sleepy" asset catalog image.
    static var sleepy: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sleepy)
#else
        .init()
#endif
    }

    /// The "Weekly HT" asset catalog image.
    static var weeklyHT: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .weeklyHT)
#else
        .init()
#endif
    }

    /// The "Wild" asset catalog image.
    static var wild: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wild)
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

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
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

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
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

