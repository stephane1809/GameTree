//
//  UikitToSwiftUI.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 11/04/23.
//

import Foundation
import SwiftUI

struct CustomView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return ViewController().view
    }

    func runUIView(context: Context) -> some UIViewController {
        return ViewController()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("update")
    }

}
