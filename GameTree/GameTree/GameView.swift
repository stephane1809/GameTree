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
    // o que é pra acontecer se o jogo terminar:
    // é pra salvar o valor
    // comparar o valor com oq ta salvo no user defaults
    // surgir o popup sem o play de continuar jogando
    // mudar a gravidade do jogo para zero pra animação parar
    // parar a criação de arvore

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
                .popupNavigationView(horizontalPadding: 100, show: $showingPopup, content: {
                    pauseView
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Pause")
                                    .font(.custom("Georgia", size: 34, relativeTo: .largeTitle))
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
            Text("\(gameModel.counterTree)")
                .foregroundColor(.black)
                .font(.custom("Georgia", size: 34, relativeTo: .largeTitle))
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
                .font(.custom("Georgia", size: 17, relativeTo: .headline))
            Image(systemName: "heart.fill")
                .foregroundColor(.black)
                .font(.custom("Georgia", size: 17, relativeTo: .headline))
            Image(systemName: "heart.fill")
                .foregroundColor(.black)
                .font(.custom("Georgia", size: 17, relativeTo: .headline))
        }
    }
    var pauseView: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("Record")
                    .foregroundColor(.black)
                    .font(.custom("Georgia", size: 17, relativeTo: .headline))

                Text("\(gameModel.counterTree)")
                    .foregroundColor(.black)
                    .font(.custom("Georgia", size: 17, relativeTo: .headline))
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
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
                        Text("Play")
                            .foregroundColor(.black)
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
                    }
                }
                Button {

                } label: {

                    VStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
                        Text("Replay")
                            .foregroundColor(.black)
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
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
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
                        Text("Sound")
                            .foregroundColor(.black)
                            .font(.custom("Georgia", size: 11, relativeTo: .caption2))
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
