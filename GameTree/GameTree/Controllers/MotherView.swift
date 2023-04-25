//
//  MotherView.swift
//  GameTree
//
//  Created by Narely Lima on 25/04/23.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
            if viewRouter.currentPage == "FirstAccessView" {
                Onboard()
            } else if viewRouter.currentPage == "GameView" {
                MainView()
            }
        }
    }
}
