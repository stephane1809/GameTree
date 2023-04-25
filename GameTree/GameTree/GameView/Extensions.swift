//
//  Extensions.swift
//  GameTree
//
//  Created by Narely Lima on 29/03/23.
//

import SwiftUI
import AVFoundation

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 100,
                                            show: Binding<Bool>,
                                            @ViewBuilder content: @escaping() -> Content) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            .overlay {
                if show.wrappedValue {
                    // MARK: Geometry Reader for reading Container Frame

                    GeometryReader { proxy in

                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        let size = proxy.size

                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height/2, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

protocol Audio {
    func playAudioView(nameAudio: String) -> AVAudioPlayer?
    func saveMoodSound()
}
