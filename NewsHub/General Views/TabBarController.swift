//
//  TabBarController.swift
//  NewsHub
//
//  Created by Kirill on 12.12.2023.
//

import UIKit



// MARK: - TabBarController
final class TabBarController: UITabBarController {
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }
    
}



// MARK: - Настройка UI
extension TabBarController {
    
    // MARK: Настройка Tab bar
    private func setUpTabBar() -> Void {
        let newsSceneViewController = self.setViewController(viewController: NewsSceneViewController(),
                                                             title: "Новости",
                                                             image: UIImage(systemName: "newspaper"))
        let categorySelectionSceneViewController = self.setViewController(viewController: CategorySelectionSceneViewController(),
                                                                          title: "Категории",
                                                                          image: UIImage(systemName: "gearshape"))
        self.setViewControllers([newsSceneViewController, categorySelectionSceneViewController], animated: false)
        self.tabBar.barTintColor = .systemGray6
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .systemGray6
    }
    
    // MARK: Настройка view conntroller'ов
    private func setViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
}
