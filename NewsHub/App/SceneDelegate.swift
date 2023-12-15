//
//  SceneDelegate.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let chosenNewsCategoriesStorageManager: NewsCategoriesStorageManagerProtocol = NewsCategoriesStorageManager.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        
        if self.isTheFirstLaunching() {
            self.chosenNewsCategoriesStorageManager.save(arrayOfCategories: [])
            window.rootViewController = CategorySelectionSceneViewController()
        } else {
            window.rootViewController = TabBarController()
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    // MARK: Проверка впервые ли запускается приложение
    private func isTheFirstLaunching() -> Bool {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: KeyForTheFirstLaunch.key) == nil {
            return true
        } else {
            return false
        }
    }
    
}

