//
//  ContentView.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 29/03/23.
//

import SwiftUI

struct ContentView: View {


    var tapped: String = ""
    @StateObject var gameModel = GameModel()
    @State var isSelected: Bool = true

    var selected = "speaker.wave.3.fill"
    var notSelected = "speaker.slash.fill"
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Text("RECORD")
                    .font(.custom("Georgia", size: 34, relativeTo: .largeTitle))
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
        }
    }

    var buttonMusic: some View {
        Button {
            withAnimation {
                isSelected.toggle()
            }
        } label: {
            Image(systemName: isSelected ? selected : notSelected)
                .foregroundColor(.black)
                .font(.custom("Georgia", size: 17, relativeTo: .headline))
        }
    }
    @ViewBuilder
    var recordsView: some View {
            HStack {
                Text("\(gameModel.record)")
                    .font(.custom("Georgia", size: 34, relativeTo: .largeTitle))
                Image(systemName: "tree")

                    .foregroundColor(.green)
                    .font(.custom("Georgia", size: 34, relativeTo: .largeTitle))
            }
    }
    var navigation: some View {
        NavigationLink(destination: GameView(), label: {
                HStack {
                    Text("Play")
                        .foregroundColor(.black)
                        .font(.custom("Georgia", size: 34, relativeTo: .title))
                    Image(systemName: "play.circle")
                        .font(.custom("Georgia", size: 34, relativeTo: .title))
                          .foregroundColor(.black)
                }
                .frame(width: 150, height: 50)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2))
        }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
