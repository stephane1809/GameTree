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
        view.backgroundColor = .green
        authenticateUser()
    }
}

extension ViewController: GKGameCenterControllerDelegate {

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    func authenticateUser() {
        var isAutheticated = GKLocalPlayer.local.isAuthenticated
        if !isAutheticated {
            let player = GKLocalPlayer.local
            player.authenticateHandler = { viewController, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                if let gameCenterViewController = viewController {
                    self.present(gameCenterViewController, animated: true, completion: nil)
                }
            }
        }
    }

    func showAchievements() {
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        viewController.viewState = .achievements
        present(viewController, animated: true, completion: nil)
    }

    func saveGameCenterLeaderboard (record: Int) {
        let local = GKLocalPlayer.local
        if GKLocalPlayer.local.isAuthenticated {
            GKLeaderboard.submitScore(record, context: 0, player: local, leaderboardIDs: ["topranking"], completionHandler: { error in
                if error != nil {
                    print(error!)
                } else {
                    print("Score \(record) submitted")
                }
            })
        } else {
            print("User not sign into Game Center")
        }
    }

    func resetAchievement() {
        GKAchievement.resetAchievements { error in
            if error != nil {
                print("Something went wrong while reseting achievement")
            } else {
                print("all done")
            }
        }
    }

    func saveAchievements(achievementID: String, percentage: Int) {
        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in

            print(achievements?.count, error)
            let achievementID = achievementID
            var achievement: GKAchievement?
            achievement = achievements?.first(where: { $0.identifier == achievementID})
            if achievement == nil {
                achievement = GKAchievement(identifier: achievementID)
            }

            achievement?.percentComplete = achievement!.percentComplete + Double(percentage)
            if error != nil {
                print("Error: \(String(describing: error))")
            }

            let achievementsToReport: [GKAchievement] = [achievement!]

            //            GKAchievement

            GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
                    achievement?.showsCompletionBanner = true
                if error != nil {
                    print("Error: \(String(describing: error))")
                }
            })
        })
    }

    func saveAllAchievemets() {
        saveAchievements(achievementID: "littlehero", percentage: 10)
                saveAchievements(achievementID: "bonsai", percentage: 4)
                saveAchievements(achievementID: "bigbonsai", percentage: 2)
                saveAchievements(achievementID: "supremepedepau", percentage: 1)
        //    }

    }

    func showLeaderboards() {
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        viewController.viewState = .leaderboards
        viewController.leaderboardIdentifier = "topranking"
        present(viewController, animated: true, completion: nil)
    }

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
}
