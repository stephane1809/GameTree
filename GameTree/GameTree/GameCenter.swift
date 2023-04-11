//
//  GameCenter.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 11/04/23.
//

import UIKit
import GameKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        authenticateUser()

    }

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

}

//struct functions {
//    func authenticationUser() -> some View {
//        let player = GKLocalPlayer.local
//
//        player.authenticateHandler = { vc, error in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//
//        }
//
//        return ContentView()
//
//    }
//}
