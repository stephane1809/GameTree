//
//  InitialScene.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 25/04/23.
//

import Foundation
import SpriteKit
import GameplayKit

class InitialScene: SKScene {

    override func didMove(to view: SKView) {
//        self.backgroundColor = SKColor(red: 158/255, green: 176/255, blue: 71/255, alpha: 1)
        setupScene()
    }

    func setupScene( ){
        removeAllActions()
        removeAllChildren()

        let textures: [SKTexture] = getTextures(with: "tree", textureAtlasName: "launch")

        let node = SKSpriteNode(texture: textures[0])
        node.position.x = self.size.width/2
        node.position.y = self.size.height/3
        node.scale(to: CGSize(width: 100, height: 100))

        self.addChild(node)

        let action = SKAction.animate(with: textures, timePerFrame: 1/TimeInterval(textures.count), resize: true, restore: true)

        node.run(SKAction.repeatForever(action))

    }

    static func makeFullscreenScene() -> InitialScene {
        let scene = InitialScene()
        scene.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }

}
