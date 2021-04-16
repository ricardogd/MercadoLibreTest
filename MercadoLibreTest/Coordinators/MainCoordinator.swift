//
//  MainCoordinator.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationItem.largeTitleDisplayMode = .always
    }

    func start() {
        let vc = MainTabBarController()
        navigationController.pushViewController(vc, animated: true)
    }
}
