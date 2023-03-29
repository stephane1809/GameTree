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
                Text("GameView")
                    .font(.largeTitle)
            }
            .popupNavigationView(horizontalPadding: 100, show: $showingPopup, content: {
                pauseView
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Pause")
                                .font(.largeTitle)
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
            Text("\(points)")
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
        HStack {
            Image(systemName: "heart")
                .foregroundColor(.black)
            Image(systemName: "heart")
                .foregroundColor(.black)
            Image(systemName: "heart")
                .foregroundColor(.black)
        }
    }
    var pauseView: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("Record")

                Text("\(points)")
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
                            .font(.title2)
                        Text("Play")
                    }
                }
                Button {

                } label: {

                    VStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                            .font(.title2)
                        Text("Replay")
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
                            .font(.title2)
                        Text("Sound")
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
