//
//  GameView.swift
//  GameTree
//
//  Created by Narely Lima on 29/03/23.
//

import SwiftUI

struct GameView: View {

    var points: Int = 23
    var selected = "speaker.wave.3.fill"
    var notSelected = "speaker.slash.fill"

    @State var showingPopup = false
    @State var isSelected: Bool = true

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
//                Text("GameView")
//                    .scaledFont(name: "Georgia", size: 11)
                GameplayView()
            }
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
            Text("\(points)")
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

                Text("\(points)")
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
