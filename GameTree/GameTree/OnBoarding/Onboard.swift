//
//  OnBoard.swift
//  GameTree
//
//  Created by Narely Lima on 25/04/23.
//

import SwiftUI
import Lottie

struct Onboard: View {
    var onBoardingModel: [Onboarding] = [
        Onboarding(asset: "leaf", desc: "Hi, small leaf"),
        Onboarding(asset: "tree_launch_00", desc: "Touch the trees to save then from the fire"),
        Onboarding(asset: "tree_launch_00", desc: "Are you ready?")
    ]
   @State private var index = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $index) {
                ForEach(0..<onBoardingModel.count, id: \.self) {model in
                    VStack(alignment: .center) {
                        if model == 0 {
                            LottieView(lottieFile: onBoardingModel[model].asset)
                                .frame(width: UIScreen.main.bounds.size.width,
                                       height: UIScreen.main.bounds.size.height * 0.18, alignment: .center)
                            Text(onBoardingModel[model].desc)
                        } else {
                            Image("tree")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.size.width,
                                       height: UIScreen.main.bounds.size.height * 0.3,
                                       alignment: .center)
                            Text(onBoardingModel[index].desc)
                        }

                        if model == 2 {
                            NavigationLink {
                                MainView()
                                    .navigationBarBackButtonHidden(true)
                                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                            } label: {
                                Text("Play now")
                                    .foregroundColor(Color.black)
                                    .font(.headline)
                                    .padding(10)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1))
                            }
                        }
                    }
                }

            }.tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding()
                .background {
                    LinearGradient(colors: [.white, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                }
        }
    }
}

struct Onboard_Previews: PreviewProvider {

    @State static var lost: Bool = false

    static var previews: some View {
        Onboard()
    }
}
