//
//  GameScene.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 29/03/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {

        print("Game loaded")

        Task {
            while true {
                try? await Task.sleep(for: .seconds(0.5))
                createTree()
            }
        }
    }

    func createTree(){
        let treeSizes: [CGSize] = [CGSize(width: 30.5, height: 41.5), CGSize(width: 61, height: 83)]
        let treePositions: [CGPoint] = [CGPoint(x: 100, y: 900), CGPoint(x: 264, y: 1400), CGPoint(x: 332, y: 1100)]

        let tree = SKSpriteNode(imageNamed: "lofiTree")
        tree.size = treeSizes.randomElement()!
        //        tree.color = .systemPurple
        tree.position = treePositions.randomElement()!
        //        tree.name = "tree"

        //physics property
        tree.physicsBody = SKPhysicsBody(rectangleOf: tree.frame.size)
        tree.physicsBody?.isDynamic = true
        //        tree.physicsBody!.affectedByGravity = true
        tree.physicsBody!.usesPreciseCollisionDetection = true


        self.addChild(tree)

        //Animations


    }


    func deleteTree(){

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createTree()
    }
}
