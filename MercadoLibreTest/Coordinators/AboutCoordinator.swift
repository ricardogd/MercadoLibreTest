//
//  AboutCoordinator.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import Foundation
import UIKit
import SwiftUI
import os.log


private struct Constants {
    static let aboutTitle = Localization.localizedString(fromKey: "navigation.title.about")
    static let aboutTabBarIcon = "About_icon"
}

class AboutCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true

        let vc = UIHostingController(rootView: AboutView())
        vc.title = Constants.aboutTitle
        vc.tabBarItem = setUpTabBar()
        
        self.navigationController.viewControllers = [vc]
        
        Logger.showingViewSuccess.info("Showing About Successfully")
    }
    
    func setUpTabBar() -> UITabBarItem {
        let customTabBarItem:UITabBarItem = UITabBarItem(title: Constants.aboutTitle,
                                                         image: UIImage(named: Constants.aboutTabBarIcon),
                                                         tag: 1)
        return customTabBarItem
    }
}
