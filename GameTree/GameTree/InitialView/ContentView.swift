//
//  ContentView.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 29/03/23.
//

import SwiftUI
import AVFoundation
import _SpriteKit_SwiftUI

struct MainView: View {
    var body: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

struct ContentView: View {
    var gameCenter = GameCenter()
    @StateObject var gameModel = GameModel.shared
    @State var goGamePlay: Bool = false
    @Environment(\.scenePhase) var scenePhase

    var selected = "speaker.wave.3.fill"
    var notSelected = "speaker.slash.fill"

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Text("RECORD")
                    .scaledFont(name: "Georgia", size: 34)
                recordsView
                HStack(alignment: .center, spacing: 40) {
                    navigation
                    }
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    buttonMusic
                }
            }
            .onAppear {
                gameCenter.authenticateUser()
//                gameCenter.resetAchievement()
                gameModel.isOnMainScreen = true
                if gameModel.record == 0 {
                    gameModel.firstAccess()
                }
                if gameModel.soundIsActive {
                    gameModel.audioView = playAudioView(nameAudio: "HomeAudio")
                    gameModel.audioView?.numberOfLoops = -1
                }
            }
            .onDisappear {
                gameModel.isOnMainScreen = false
                gameModel.audioView?.stop()
            }
            .onChange(of: gameModel.isSelected) { _ in
                if gameModel.soundIsActive, gameModel.isOnMainScreen {
                    gameModel.audioView = playAudioView(nameAudio: "HomeAudio")
                } else {
                    gameModel.audioView?.stop()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    if gameModel.soundIsActive, gameModel.isOnMainScreen {
                        gameModel.audioView?.play()
                    }
                } else if newPhase == .inactive {
                    gameModel.audioView?.pause()
                }
            }
            .preferredColorScheme(.light)
        }
    }

    var buttonMusic: some View {
        Button {
            withAnimation {
                gameModel.isSelected = !gameModel.soundIsActive

                if gameModel.isSelected {
                    gameModel.audioView = playAudioView(nameAudio: "HomeAudio")
                }
                saveMoodSound()
            }
        } label: {
            Image(systemName: gameModel.soundIsActive ? selected : notSelected)
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)
        }
    }
    var recordsView: some View {
            HStack {
                Text("\(gameModel.record)")
                    .scaledFont(name: "Georgia", size: 34)
                Image("tree")
                    .resizable()
                    .frame(width: 64, height: 96)

                    .foregroundColor(.green)
                    .scaledFont(name: "Georgia", size: 34)
            }
            .preferredColorScheme(.light)
    }


    var navigation: some View {
        NavigationLink(
            destination: GameView().navigationBarBackButtonHidden(),
            label: {
                HStack {
                    Text("Play")
                        .foregroundColor(.black)
                        .scaledFont(name: "Georgia", size: 34)
                    Image(systemName: "play.circle")
                        .scaledFont(name: "Georgia", size: 34)
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 50)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2))
            }
        )
    }
}

extension ContentView: Audio {
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
