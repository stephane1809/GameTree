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
    @Published var lifesOverOne: Bool = false
    @Published var lifesOverTwo: Bool = false
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false

    var record: Int { UserDefaults.standard.integer(forKey: "tree") }

    static let shared = GameModel()

    func reset() {
        self.counterTree = 0
        self.counterFall = 0
        self.lifesOverOne = false
        self.lifesOverTwo = false
        self.isGameOver = false
        self.isPaused = false
    }
}
