//
//  GameplayView.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 29/03/23.
//

import SwiftUI
import SpriteKit

struct GameplayView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        return scene
    }

    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea(.all)
        }

    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
