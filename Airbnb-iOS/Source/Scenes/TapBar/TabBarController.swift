//
//  TabBarController.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

final class TabBarController: UITabBarController {

    private let tabBarItems = TabBarItem.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(setViewController(tabBarItems), animated: true)
        setUpTabBar()
    }

    private func setUpTabBar() {
        self.tabBar.tintColor = .main1
        self.tabBar.unselectedItemTintColor = .grayGrayIcon

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .whiteWhite
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }


    private func setViewController(_ tabBarItems: [TabBarItem]) -> [UIViewController] {
        tabBarItems.map { tabBarItem in
            let viewController: UIViewController

            switch tabBarItem {
            case .search:
                viewController = UINavigationController(rootViewController: ExploreViewController())
            case .wishList:
                viewController = UINavigationController(rootViewController: ExploreViewController())
            case .trip:
                viewController = UINavigationController(rootViewController: ExploreViewController())
            case .message:
                viewController = UINavigationController(rootViewController: ExploreViewController())
            case .profile:
                viewController = UINavigationController(rootViewController: ExploreViewController())
            }

            viewController.tabBarItem = tabBarItem.toTabBarItem()
            return viewController
        }
    }
}
