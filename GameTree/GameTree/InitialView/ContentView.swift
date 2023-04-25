//
//  ContentView.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 29/03/23.
//

import SwiftUI
import AVFoundation
import _SpriteKit_SwiftUI

struct ContentView: View {

    var tapped: String = ""
    @StateObject var gameModel = GameModel.shared
    @State var goGamePlay: Bool = false

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
                gameModel.isOnMainScreen = true
                if gameModel.record == 0 {
                    gameModel.firstAccess()
                }
                if gameModel.soundIsActive {
                    gameModel.audioView = playAudioView(nameAudio: "HomeAudio")
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
                Image(systemName: "tree")

                    .foregroundColor(.green)
                    .scaledFont(name: "Georgia", size: 34)
            }
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
