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
        Onboarding(lottie: "leaf", desc: "Hi, small leaf", button: "", height: UIScreen.main.bounds.size.height * 0.4),
        Onboarding(lottie: "tree", desc: "Touch the trees to save then from the fire",
                   button: "", height: UIScreen.main.bounds.size.height * 0.4),
        Onboarding(lottie: "fire", desc: "Are you ready?", button: "Let's go", height: UIScreen.main.bounds.size.height * 0.2)
    ]
   @State private var index = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $index) {
                ForEach(0..<onBoardingModel.count, id: \.self) {model in
                    VStack(alignment: .center) {
                        LottieView(lottieFile: onBoardingModel[model].lottie)
                            .frame(width: UIScreen.main.bounds.size.width,
                                   height: onBoardingModel[model].height, alignment: .center)
//                            .padding(.top, 100)
                        
                        Text(onBoardingModel[index].desc)

                        if onBoardingModel[index].button != "" {
                            NavigationLink {
                                MainView()
                                    .navigationBarBackButtonHidden(true)
                                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                            } label: {
                                Text(onBoardingModel[index].button)
                                    .foregroundColor(Color.white)
                                    .font(.title3)
                                    .padding()
                                    .cornerRadius(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
//                                    .frame(width: UIScreen.main.bounds.size.height * 0.2, height: UIScreen.main.bounds.size.height * 0.2)
                            }
                        }
                    }
                }

            }.tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding()
        }
    }
}

struct Onboard_Previews: PreviewProvider {

    @State static var lost: Bool = false

    static var previews: some View {
        Onboard()
    }
}
