//
//  SceneDelegate.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationViewController = UINavigationController(rootViewController: ReviewListViewController())
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

