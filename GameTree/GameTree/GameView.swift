//
//  GameView.swift
//  GameTree
//
//  Created by Narely Lima on 29/03/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {

    // o que é pra acontecer se houver mudanca de pontos?
    // comparar com valor salvo no userdefaults(game center dps)

    var selected = "speaker.wave.3.fill"
    var notSelected = "speaker.slash.fill"

    @StateObject var gameModel = GameModel.shared

    @State var showingPopup = false

    @State var isSelected: Bool = true
    // quando eu selecionar oq é pra acontecer?
    // é pra desligar o audio do aplicativo --> fazer um didSet

    @StateObject var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()

    var body: some View {
        NavigationView {
            SpriteView(scene: scene)
                .ignoresSafeArea(.all)
                .popupNavigationView(horizontalPadding: 100, show: $gameModel.isGameOver, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(gameModel.isGameOver ? "Game Over" : "Pause")
                                    .scaledFont(name: "Georgia", size: 34)
                                    .fontWeight(.bold)
                            }
                        }
                })
                .popupNavigationView(horizontalPadding: 100, show: $showingPopup, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(gameModel.isGameOver ? "Game Over" : "Pause")
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
        }
        .onChange(of: gameModel.isPaused || gameModel.isGameOver) { newValue in
            scene.isPaused = newValue
            print(newValue)
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
                        isSelected.toggle()
                    }
                } label: {
                    VStack {
                        Image(systemName: isSelected ? selected : notSelected)
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
