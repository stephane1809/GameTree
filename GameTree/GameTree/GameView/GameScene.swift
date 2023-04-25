//
//  GameScene.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 29/03/23.
//

import Foundation
import SwiftUI
import SpriteKit
import AVFoundation

class GameScene: SKScene, ObservableObject {

    var gameModel = GameModel.shared
    var incrementGravity: Double = 0.0
    var lastTreeCreation: TimeInterval = .zero

    var realPaused: Bool = false {
        didSet {
            self.isPaused = realPaused
        }
    }

    override var isPaused: Bool {
        didSet {
            if self.isPaused == false && self.realPaused == true {
                self.isPaused = true
            }
        }
    }

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        addLaserFloor()
        createFire()
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if gameModel.isPaused == false && gameModel.isGameOver == false && currentTime - lastTreeCreation > 0.9 {
            createTree()
            incrementGravity += 0.01
            lastTreeCreation = currentTime
            physicsWorld.gravity = CGVector(dx: 0, dy: -0.3 - incrementGravity)
        }
    }

    static func makeFullscreenScene() -> GameScene {
        let scene = GameScene()
        scene.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }

    func createTree() {
//            let treeSizes: [CGSize] = [CGSize(width: 30.5, height: 41.5), CGSize(width: 61, height: 83)]
            let treePositions: [CGPoint] = [CGPoint(x: 100, y: 880), CGPoint(x: 264, y: 880), CGPoint(x: 332, y: 880)]
        
            let textures: [SKTexture] = getTextures(with: "tree", textureAtlasName: "tree_fall")

            let tree = SKSpriteNode(texture: textures[0])
            tree.position.x = self.size.width/2
            tree.position.y = self.size.height/3
            tree.scale(to: CGSize(width: 100, height: 150))
//        tree.size = treeSizes.randomElement()!
        tree.position = treePositions.randomElement()!
        tree.name = "tree"


        // physics property
        tree.physicsBody = SKPhysicsBody(rectangleOf: tree.frame.size)
        tree.physicsBody?.isDynamic = true
        tree.physicsBody!.affectedByGravity = true
        tree.physicsBody!.usesPreciseCollisionDetection = false
        tree.physicsBody?.contactTestBitMask = MascaraBit.Laser
        tree.physicsBody?.collisionBitMask = 0

            let action = SKAction.animate(with: textures, timePerFrame: 10/TimeInterval(textures.count), resize: true, restore: true)

            tree.run(SKAction.repeatForever(action))
//            self.addChild(node)

//            let tree = SKSpriteNode(imageNamed: "lofiTree")

            self.addChild(tree)
    }

    func createFire() {
        let textures: [SKTexture] = getTextures(with: "fire", textureAtlasName: "fires")

        let node = SKSpriteNode(texture: textures[0])

        node.position.x = 200
        node.position.y = 150

        node.scale(to: CGSize(width: 400, height: 400))

        let action = SKAction.animate(with: textures, timePerFrame: 1/TimeInterval(textures.count), resize: true, restore: true)

        node.run(SKAction.repeatForever(action))

        self.addChild(node)
    }

    func addLaserFloor() {
        let laser = SKShapeNode()
        laser.position = CGPoint(x: self.size.width, y: 0)
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width*2, height: 1))
        laser.fillColor = .blue
        laser.physicsBody?.isDynamic = false
        laser.physicsBody?.contactTestBitMask = MascaraBit.Laser
        laser.physicsBody?.categoryBitMask = MascaraBit.Laser
        laser.physicsBody?.collisionBitMask = 0
        laser.name = "Laser"

        addChild(laser)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)

            if touchedNode.name == "tree" {
                gameModel.counterTree += 1
                if gameModel.counterTree > gameModel.record {
                    UserDefaults.standard.set(gameModel.counterTree, forKey: "tree")
                }
                touchedNode.removeFromParent()
                if gameModel.soundIsActive {
                    gameModel.touchSound = playAudioView(nameAudio: "TreeCollect2")
                }
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Laser" || contact.bodyB.node?.name == "Laser" {
            gameModel.counterFall += 1
            if gameModel.soundIsActive {
                gameModel.touchSound = playAudioView(nameAudio: "LostLife")
            }
            if gameModel.counterFall == 1 {
                gameModel.lifesOverOne = true
            }
            if gameModel.counterFall == 2 {
                gameModel.lifesOverTwo = true
            }
            if gameModel.counterFall == 3 {
                gameModel.isGameOver = true
                if gameModel.soundIsActive {
                    gameModel.gameOverSound = playAudioView(nameAudio: "GameOverAudio")
                    gameModel.gameAudio?.stop()
                }
            }
        }
    }
}
extension GameScene: Audio {
    func playAudioView(nameAudio: String) -> AVAudioPlayer? {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: nameAudio, ofType: "mp3")!)
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL as URL)
            player.play()
            return player
        } catch {
            print("there was some error. The error was \(error)")
            return nil
        }
    }
    func saveMoodSound() {
        UserDefaults.standard.set(gameModel.isSelected, forKey: "sound")
    }
}

struct MascaraBit {
    static let Laser: UInt32 = 2
}
