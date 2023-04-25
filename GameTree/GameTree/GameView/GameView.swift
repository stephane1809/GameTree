//
//  GameView.swift
//  GameTree
//
//  Created by Narely Lima on 29/03/23.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct GameView: View {

    // o que é pra acontecer se houver mudanca de pontos?
    // comparar com valor salvo no userdefaults(game center dps)

    var selected = "speaker.wave.3.fill"
    var notSelected = "speaker.slash.fill"

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var gameModel = GameModel.shared
    @State var showingPopup = false

    @State var scene: GameScene = .makeFullscreenScene()

    var body: some View {
        NavigationView {
            SpriteView(scene: scene)
                .ignoresSafeArea(.all)
                .popupNavigationView(horizontalPadding: 100, show: $gameModel.isGameOver, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(gameModel.isGameOver ? "Game Over" : "")
                                    .scaledFont(name: "Georgia", size: 34)
                                    .fontWeight(.bold)
                            }
                        }
                })
                .popupNavigationView(horizontalPadding: 100, show: $showingPopup, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(showingPopup ? "Pause" : "")
                                    .scaledFont(name: "Georgia", size: 34)
                                    .fontWeight(.bold)
                            }
                        }
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        titlePoints
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        gameModel.isGameOver ? nil : buttonPause
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        remainingLifes
                    }
                }
                .onAppear {
                    gameModel.gameAudio = playAudioView(nameAudio: "GameAudio")
                    if gameModel.soundIsActive {
                        if gameModel.isGameOver {
                            gameModel.gameAudio?.stop()
                        } else {
                            gameModel.gameAudio?.play()
                        }
                    } else {
                        gameModel.gameAudio?.stop()
                    }
                }
                .onDisappear {
                    if gameModel.isSelected {
                        gameModel.gameAudio?.stop()
                    }
                }
        }
        .onChange(of: gameModel.isPaused || gameModel.isGameOver) { newValue in
            scene.realPaused = newValue
        }
    }

    var titlePoints: some View {
        HStack {
            Image(systemName: "tree")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 28)
            Text("\(gameModel.counterTree)")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 28)
        }
    }
    var buttonPause: some View {
        Button {
            gameModel.isPaused.toggle()
            withAnimation {
                showingPopup.toggle()
            }
        } label: {
            Image(systemName: "pause.fill")
                .foregroundColor(.black)
        }
    }
    var remainingLifes: some View {
        HStack(spacing: 3) {

            Image(systemName: gameModel.isGameOver ? "heart" : "heart.fill")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)

            Image(systemName: gameModel.lifesOverTwo ? "heart" : "heart.fill")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)

            Image(systemName: gameModel.lifesOverOne ? "heart" : "heart.fill")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)

        }
    }
    var pauseView: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("Record")
                    .foregroundColor(.black)
                    .scaledFont(name: "Georgia", size: 17)
                Text("\(gameModel.record)")
                    .foregroundColor(.black)
                    .scaledFont(name: "Georgia", size: 17)
            }
            HStack {
                Text("Your scores")
                    .foregroundColor(.black)
                    .scaledFont(name: "Georgia", size: 17)

                Text("\(gameModel.counterTree)")
                    .foregroundColor(.black)
                    .scaledFont(name: "Georgia", size: 17)
            }
            HStack(alignment: .center, spacing: 20) {
                gameModel.isGameOver ? nil : Button {
                    withAnimation {
                        gameModel.isGameOver = false
                        showingPopup.toggle()
                        gameModel.isPaused.toggle()
                    }
                } label: {
                    VStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                        Text("Continue")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                    }
                }

                Button {
                    scene = GameScene.makeFullscreenScene()
                    scene.gameModel.reset()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                        Text("Replay")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                    }
                }
                Button {
                    withAnimation {
                        gameModel.isSelected = !gameModel.soundIsActive
                        saveMoodSound()
                        gameModel.gameAudio = playAudioView(nameAudio: "GameAudio")
                        if gameModel.soundIsActive {
                            gameModel.gameAudio?.play()
                       } else {
                           gameModel.gameAudio?.stop()
                       }
                    }
                } label: {
                    VStack {
                        Image(systemName: gameModel.soundIsActive ? selected : notSelected)
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                        Text("Sound")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                    }
                }
            }
        }
    }
}

extension GameView: Audio {
    func playAudioView(nameAudio: String) -> AVAudioPlayer? {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: nameAudio, ofType: "mp3")!)
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL as URL)
            player.play()
            return player
        } catch {
            print("there was some error. The error was \(error)")
            return nil
        }
    }
    func saveMoodSound() {
        UserDefaults.standard.set(gameModel.isSelected, forKey: "sound")
    }
}
