//
//  GameTreeApp.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 29/03/23.
//

import SwiftUI

@main
struct GameTreeApp: App {
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(ViewRouter())
        }
    }
}
