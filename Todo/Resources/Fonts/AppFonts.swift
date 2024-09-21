import UIKit

extension UIFont {
    static let headline: UIFont = InterFontFactory.uiFont(
        size: 32,
        weight: .bold
    )
    static let headline2: UIFont = InterFontFactory.uiFont(
        size: 18,
        weight: .bold
    )
    static let content: UIFont = InterFontFactory.uiFont(
        size: 18,
        weight: .medium
    )
    static let contentSecondary: UIFont = InterFontFactory.uiFont(
        size: 14,
        weight: .semiBold
    )
}

public enum InterFont: String {
    case black = "Inter-Black"
    case bold = "Inter-Bold"
    case extraBold = "Inter-ExtraBold"
    case extraLight = "Inter-ExtraLight"
    case light = "Inter-Light"
    case medium = "Inter-Medium"
    case regular = "Inter-Regular"
    case semiBold = "Inter-SemiBold"
    case thin = "Inter-Thin"
    
//    public static func registerFonts() {
//        Self.allCases.forEach { font in
//            Self.registerFont(bundle: .main, fontName: font.rawValue, fontExtension: "ttf")
//        }
//    }
//    
//    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
//        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
//              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
//              let font = CGFont(fontDataProvider)
//        else {
//            assertionFailure("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
//            return
//        }
//
//        var error: Unmanaged<CFError>?
//
//        CTFontManagerRegisterGraphicsFont(font, &error)
//        if error != nil {
//            assertionFailure(
//                "Couldn't create font from filename: \(fontName) with extension \(fontExtension) with error: \(error.debugDescription)"
//            )
//        }
//    }
}

public enum InterFontFactory {
    private static var registered: Bool = false
    
    public static func uiFont(
        size: CGFloat,
        weight: InterFont
    ) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            assertionFailure("Cannot find font \(weight.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}



