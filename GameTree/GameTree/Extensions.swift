//
//  Extensions.swift
//  GameTree
//
//  Created by Narely Lima on 29/03/23.
//

import SwiftUI

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
                        .frame(width: size.width - horizontalPadding, height: size.height/4, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
