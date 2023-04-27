//
//  SplashScreenView.swift
//  GameTree
//
//  Created by Narely Lima on 26/04/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false

    @State var splashImage = ""

    @State private var timer: Timer?

    var body: some View {
        if isActive {
            MotherView().environmentObject(ViewRouter())
        } else {
            ZStack {
                Color.init(red: 235/255, green: 252/255, blue: 240/255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image(splashImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .onAppear {
                            splashTrees()
                        }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
    func heartLifes() {
        var index = 0
        timer = Timer.scheduledTimer(
            withTimeInterval: 1/5,
            repeats: true
        ) { (timer) in
            splashImage = "tree_burn_0\(index)"
            index += 1
            if index > 3 {
                index = 0

            }
        }
        timer?.fire()
    }

    func splashTrees() {
        var index = 1
        timer = Timer.scheduledTimer(
            withTimeInterval: 1/5,
            repeats: true
        ) { (timer) in
            splashImage = "tree\(index)"
            index += 1
            if index > 3 {
                index = 0

            }
        }
        timer?.fire()
    }
}

struct SplashScreenView_Previews: PreviewProvider {

    @State static var lost: Bool = false

    static var previews: some View {
        SplashScreenView()
    }
}
