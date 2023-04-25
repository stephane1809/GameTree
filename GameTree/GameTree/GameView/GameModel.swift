//
//  GameModel.swift
//  GameTree
//
//  Created by Narely Lima on 03/04/23.
//

import Foundation
import AVFoundation

class GameModel: ObservableObject {
    @Published var counterTree: Int = 0
    @Published var counterFall: Int = 0
    @Published var lifesOverOne: Bool = false
    @Published var lifesOverTwo: Bool = false
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var isSelected: Bool = true
    @Published var isOnMainScreen: Bool = false
    @Published var audioView: AVAudioPlayer?
    @Published var audioPlay: AVAudioPlayer?
    @Published var touchSound: AVAudioPlayer?
    @Published var gameAudio: AVAudioPlayer?
    @Published var gameOverSound: AVAudioPlayer?
    var soundIsActive: Bool { UserDefaults.standard.bool(forKey: "sound") }
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

    func firstAccess() {
        UserDefaults.standard.set(true, forKey: "sound")
    }
}
