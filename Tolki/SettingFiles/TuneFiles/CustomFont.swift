//
//  CustomFont.swift
//  Tolki
//
//  Created by Эльвира on 02.12.2024.
//

import SwiftUI

enum TextStyle {
    case display
    case h1
    case h2
    case h3
    case h3Button
    case h4
    case text

    var fontName: String {
        switch self {
        case .text, .h3:
            return "FormaDJRCyrillicText-Regular"
        default:
            return "FormaDJRCyrillicText-Medium"
        }
    }

    var size: CGFloat {
        switch self {
        case .display: return 32
        case .h1: return 24
        case .h2: return 20
        case .h3Button, .h3: return 18
        case .h4, .text: return 15
        }
    }

    var letterSpacing: CGFloat {
        switch self {
        case .h1, .display: return 0.72
        case .h2: return 0.6
        case .h3Button, .h3: return 0.48
        case .h4, .text: return 0.36
        }
    }

    var lineHeight: CGFloat? {
        switch self {
        case .h1, .display: return 26.4
        case .h2: return 22.0
        case .h4, .text: return 13.2
        default: return nil
        }
    }

    
    
}

struct CustomTextStyle: ViewModifier {
    let style: TextStyle

    func body(content: Content) -> some View {
        var text = content
            .font(.custom(style.fontName, size: style.size))
            .tracking(style.letterSpacing)

       

        return text
    }
}

extension View {
    func customTextStyle(_ style: TextStyle) -> some View {
        self.modifier(CustomTextStyle(style: style))
    }
}
