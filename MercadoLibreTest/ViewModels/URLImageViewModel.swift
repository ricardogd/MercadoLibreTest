//
//  URLImageViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import SwiftUI

class URLImageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var image: UIImage = UIImage(named: "photo.on.rectangle") ?? UIImage()
    
    var urlString: String
    
    init(url: String) {
        self.urlString = url
        self.isLoading = true
        getImage(from: url)
    }
    
    func getImage(from urlString: String) {
        let serviceProvider = ServiceProvider.getImageClient
        serviceProvider.getImage(fromURL: urlString) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data) ?? UIImage()
                    self?.isLoading = false
                }
                break
            case .failure(_):
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "photo.on.rectangle") ?? UIImage()
                    self?.isLoading = false
                }
                break
            }
        }
    }
}
