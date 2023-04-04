//
//  GameModel.swift
//  GameTree
//
//  Created by Narely Lima on 03/04/23.
//

import Foundation

class GameModel: ObservableObject {
    @Published var counterTree: Int = 0
    @Published var counterFall: Int = 0
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var record = UserDefaults.standard.integer(forKey: "tree")
    static let shared = GameModel()
}
