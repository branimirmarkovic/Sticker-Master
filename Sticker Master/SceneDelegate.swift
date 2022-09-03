//
//  SceneDelegate.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let provider = LocalQatarWorldCupAlbumProvider()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: scene.screen.bounds)
        self.window = window
        configureWindow(window, with: scene)
        window.makeKeyAndVisible()
        
        let viewModel = AlbumViewModel(albumProvider: provider)
        
        window.rootViewController = AlbumViewController(viewModel: viewModel, collectionViewLayoutProvider: DefaultCollectionViewLayoutProvider())
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


    private func configureWindow(_ window: UIWindow, with scene: UIWindowScene) {
        window.canResizeToFitContent = true
        window.windowScene = scene
    }
}

