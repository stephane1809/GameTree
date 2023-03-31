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

    @State var showingPopup = false
    @State var isGameOver: Bool = false
    // o que é pra acontecer se o jogo terminar:
    // é pra salvar o valor
    // comparar o valor com oq ta salvo no user defaults
    // surgir o popup sem o play de continuar jogando
    // mudar a gravidade do jogo para zero pra animação parar

    @State var isSelected: Bool = true
    // quando eu selecionar oq é pra acontecer?
    // é pra desligar o audio do aplicativo --> fazer um didSet

    @StateObject var scene: GameScene = {
            let scene = GameScene()
            scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            scene.scaleMode = .fill
            scene.backgroundColor = .white
            scene.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
            return scene
        }()

    var body: some View {
        NavigationView {
            SpriteView(scene: scene)
                .ignoresSafeArea(.all)
                .popupNavigationView(horizontalPadding: 100, show: $showingPopup, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Pause")
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
                        buttonPause
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        remainingLifes
                    }
                }
        }
    }

    var titlePoints: some View {
        HStack {
            Image(systemName: "tree")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 28)
            Text("\(scene.counterTree)")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 28)
        }
    }
    var buttonPause: some View {
        Button {
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
            Image(systemName: "heart.fill")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)
            Image(systemName: "heart.fill")
                .foregroundColor(.black)
                .scaledFont(name: "Georgia", size: 17)
            Image(systemName: "heart.fill")
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

                Text("\(scene.counterTree)")
                    .foregroundColor(.black)
                    .scaledFont(name: "Georgia", size: 17)
            }
            HStack(alignment: .center, spacing: 20) {
                Button {
                    withAnimation {
                        showingPopup.toggle()
                    }
                } label: {
                    VStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.black)
                            .scaledFont(name: "Georgia", size: 11)
                        Text("Play")
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
