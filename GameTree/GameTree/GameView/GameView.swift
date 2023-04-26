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
    @Environment(\.scenePhase) var scenePhase

    @State var gameModel = GameModel.shared
    @State var showingPopup = false
    @State var heartImage = ""

    @State var scene: GameScene = .makeFullscreenScene()

    var body: some View {
        NavigationView {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .ignoresSafeArea(.all)
                .background {
                    LinearGradient(colors: [Color(hue: 202/360, saturation: 49/100, brightness: 100/100), Color(hue: 216/360, saturation: 61/100, brightness: 88/100, opacity: 0.18), Color(hue: 4/360, saturation: 1, brightness: 1, opacity: 0.18)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                }                .popupNavigationView(horizontalPadding: 100, show: $gameModel.isGameOver, content: {
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
                    gameModel.gameAudio?.numberOfLoops = -1
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
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if gameModel.soundIsActive {
                    gameModel.gameAudio?.play()
                } else {
                    gameModel.gameAudio?.stop()
                }
                gameModel.isPaused = true
                showingPopup = true
            } else if newPhase == .inactive {
                gameModel.touchSound?.stop()
                gameModel.gameAudio?.pause()
                scene.realPaused = true
            }
        }
    }

    var titlePoints: some View {
        HStack {
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
            Image("pause")
        }
    }
    var remainingLifes: some View {
        HStack(spacing: -8) {
            RemainLifesView(lost: $gameModel.isGameOver)
            RemainLifesView(lost: $gameModel.lifesOverTwo)
            RemainLifesView(lost: $gameModel.lifesOverOne)
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
