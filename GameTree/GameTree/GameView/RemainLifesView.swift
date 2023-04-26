//
//  RemainLifesView.swift
//  GameTree
//
//  Created by Narely Lima on 25/04/23.
//

import SwiftUI

struct RemainLifesView: View {

    @State var heartImage = ""

    @Binding var lost: Bool

    @State private var timer: Timer?

    var body: some View {
        Image(lost ? heartImage : "heart_00")
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .onChange(of: lost) { newValue in
                print(newValue)
                heartLifes()
            }
    }

    func heartLifes() {
        var index = 0
        timer = Timer.scheduledTimer(
            withTimeInterval: 1/10,
            repeats: true
        ) { (timer) in
            heartImage = "heart_0\(index)"
            index += 1
            if index > 5 {
                index = 0
                timer.invalidate()
            }
        }
        timer?.fire()
    }
}

struct RemainLifesView_Previews: PreviewProvider {

    @State static var lost: Bool = false

    static var previews: some View {
        RemainLifesView(lost: $lost)
    }
}
