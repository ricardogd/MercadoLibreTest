//
//  HomeCoordinator.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import Foundation
import UIKit
import SwiftUI

private struct Constants {
    static let homeTitle = "Home"
    static let homeTabBarIcon = "Home_icon"
}

class HomeCoordinator: Coordinator {
    
    //MARK: - Coordinator Delegate implementation
    var navigationController: UINavigationController

    //MARK: - Constructor
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        setUpNavigationController()
        setUpRootViewController()
    }
    
    //MARK: - SetUp
    func setUpNavigationController() {
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func setUpRootViewController() {
        let homeViewModel = HomeViewModel(coordinator: self)
        let vc = UIHostingController(rootView: HomeView(homeViewModel: homeViewModel))
        vc.title = Constants.homeTitle
        vc.tabBarItem = setUpTabBar()
        self.navigationController.viewControllers = [vc]
    }
    
    func setUpTabBar() -> UITabBarItem {
        let customTabBarItem:UITabBarItem = UITabBarItem(title: Constants.homeTitle,
                                                         image: UIImage(named: Constants.homeTabBarIcon),
                                                         tag: 0)
        return customTabBarItem
    }
    
    //MARK: - Navigation
    func navigateToCategory() {
        let vc = UIHostingController(rootView: ProductsListView())
        self.navigationController.pushViewController(vc, animated: true)
    }
}
