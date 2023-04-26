//
//  ViewRouter.swift
//  GameTree
//
//  Created by Narely Lima on 25/04/23.
//

import Foundation
class ViewRouter: ObservableObject {

    @Published var currentPage: String = ""

    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "FirstAccessView"
        } else {
            currentPage = "GameView"
        }
    }
}
