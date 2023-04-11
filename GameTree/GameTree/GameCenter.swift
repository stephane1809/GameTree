//
//  GameCenter.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 11/04/23.
//

import GameKit
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        authenticateUser()
//        showAchievements()
        view.addSubview(buttonAnchievements)
        setUpConstraints()
        print("aqui1")

    }

    lazy var buttonAnchievements: UIButton = {
        let button = UIButton()
        button.setTitle("Anchievements", for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(showAchievements), for: .touchUpInside)
        print("aqui3")
        return button
    }()


    
    
    func setUpConstraints (){
        NSLayoutConstraint.activate([
            buttonAnchievements.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAnchievements.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonAnchievements.heightAnchor.constraint(equalToConstant: 100),
            buttonAnchievements.widthAnchor.constraint(equalToConstant: 100)
        ])
    }


}

extension ViewController: GKGameCenterControllerDelegate {

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    func authenticateUser() {

        let player = GKLocalPlayer.local
        player.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            self.present(vc!, animated: true, completion: nil)
        }

    }

    @objc func showAchievements() {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .achievements
        present(vc, animated: true, completion: nil)
        print("aqui2")

    }
    
    func showLeaderboards(){
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "topranking"
        present(vc, animated: true, completion: nil)
    }
    // sender do botao vem aqui
    func unlockAchievement() {
        let achievement = GKAchievement(identifier: "littlehero")
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement]) { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Done")
        }
    }
    
    // sender aqui tb
    func submit() {
        let score = GKScore(leaderboardIdentifier: "topranking")
        score.value = 100
        GKScore.report([score]) { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Done")
        }
    }

}
