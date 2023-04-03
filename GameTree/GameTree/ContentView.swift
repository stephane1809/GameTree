//
//  ContentView.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 29/03/23.
//

import SwiftUI

struct ContentView: View {

    var record = UserDefaults.standard.integer(forKey: "records")

    var tapped: String = ""
    @State var isSelected: Bool = true

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
                .scaledFont(name: "Georgia", size: 17)
        }
    }

    var recordsView: some View {
        HStack {
            Text("\(record)")
                .scaledFont(name: "Georgia", size: 34)
            Image(systemName: "tree")

                .foregroundColor(.green)
                .scaledFont(name: "Georgia", size: 34)
        }
    }
    var navigation: some View {
        NavigationLink(destination: GameView().navigationBarBackButtonHidden(), label: {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
