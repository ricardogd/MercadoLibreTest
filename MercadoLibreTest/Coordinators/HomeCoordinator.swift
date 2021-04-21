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
    static let homeTitle = "Inicio"
    static let homeTabBarIcon = "Home_icon"
    static let productsTitle = "Productos"
    static let productDetailTitle = "Detalle del Producto"
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
    func navigateToCategory(withCategoryId id: String) {
        let productListViewModel = ProductListViewModel(coordinator: self, withCategoryId: id)
        let vc = UIHostingController(rootView: ProductsListView(productListViewModel: productListViewModel))
        vc.title = Constants.productsTitle
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToProduct(withProductId id: String) {
        let productDetailViewModel = ProductDetailViewModel(coordinator: self, withProductId: id)
        let vc = UIHostingController(rootView: ProductDetailView(productDetailVM: productDetailViewModel))
        vc.title = Constants.productDetailTitle
        self.navigationController.pushViewController(vc, animated: true)
    }
}
