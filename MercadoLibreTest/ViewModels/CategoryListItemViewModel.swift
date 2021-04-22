//
//  CategoryListItemViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation
import Combine
import SwiftUI

class CategoryListItemViewModel: ObservableObject {
    
    //MARK: - Published Variables
    @Published var name: String = ""
    @Published var image: UIImage = UIImage(named: "CategoryPlaceHolder") ?? UIImage()
    @Published var listItemHeight: CGFloat = 0
    
    //MARK: - Constructor
    init(categoryDetail: CategoryDetail) {
        name = categoryDetail.name
        getImage(fromURL: categoryDetail.picture)
        getCategoryListItemHeight()
    }
    
    //MARK: - Service Calls
    func getImage(fromURL url: String) {
        let serviceProvider = ServiceProvider.getImageClient
        serviceProvider.getImage(fromURL: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data) ?? UIImage()
                }
                break
            case .failure(_):
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "CategoryPlaceHolder") ?? UIImage()
                }
                break
            }
        }
    }
    
    //MARK: UI Business Rules
    func getCategoryListItemHeight() {
        // 0.9594 -> Aspect ratio W/H defined to resize the CategoryListItem to looks like a portrait rectangle image
        // 20 -> Widht padding used in the CategoryListItem
        let viewWidth = UIScreen.main.bounds.width
        let height = (viewWidth - 20) / 0.9594
        listItemHeight = height
    }
}
