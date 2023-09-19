//
//  FontManager.swift
//  li
//
//  Created by 박승찬 on 2023/09/19.
//

import Foundation
import SwiftUI

extension Font {
    enum Fonts {
        case sf_Pro
        case sf_Mono
        case apple_SD_Gothic_Neo
        
        
        var value: String {
            switch self {
            case .sf_Pro:
                return "SFPro-SemiBold"
            case .sf_Mono:
                return "SFMono-Bold"
            case .apple_SD_Gothic_Neo:
                return "AppleSDGothicNeo-Bold"
            }
        }
    }
}

struct FontManager: ViewModifier {
    var fontType: Font.Fonts
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontType.value, size: size))
    }
}

extension View {
    func titleFont1(fontType: Font.Fonts = .sf_Pro, size: CGFloat = 40.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
    }
    
    func titleFont2(fontType: Font.Fonts = .apple_SD_Gothic_Neo, size: CGFloat = 32.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
            .lineSpacing(7)
            .multilineTextAlignment(.center)
    }
    
    func titleFont3(fontType: Font.Fonts = .apple_SD_Gothic_Neo, size: CGFloat = 24.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
            .lineSpacing(8)
            .kerning(0.3)
            .multilineTextAlignment(.center)
    }
    
    func timeFont(fontType: Font.Fonts = .sf_Mono, size: CGFloat = 20.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
            .kerning(-0.5)
            .multilineTextAlignment(.center)
    }
    
    func bodyFont(fontType: Font.Fonts = .apple_SD_Gothic_Neo, size: CGFloat = 20.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
            .multilineTextAlignment(.center)
    }
    
    func subTextFont(fontType: Font.Fonts = .apple_SD_Gothic_Neo, size: CGFloat = 16.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
            .lineSpacing(6)
            .multilineTextAlignment(.center)
    }
    
    func calloutFont(fontType: Font.Fonts = .apple_SD_Gothic_Neo, size: CGFloat = 14.0) -> some View {
        self.modifier(FontManager(fontType: fontType, size: size))
    }
}
