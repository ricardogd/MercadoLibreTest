//
//  URLImageViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import SwiftUI

class URLImageViewModel: ObservableObject {
    
    //MARK: Publised Variables
    @Published var isLoading = false
    @Published var image: UIImage = UIImage(systemName: "photo.on.rectangle") ?? UIImage()
    
    //MARK: - Variables
    var urlString: String
    var serviceProvider: GetImageServiceClient
    
    //MARK: - Constructor
    init(url: String, serviceProvider: GetImageServiceClient = ServiceProvider.getImageClient) {
        self.urlString = url
        self.serviceProvider = serviceProvider
        self.isLoading = true
        getImage(from: url)
    }
    
    //MARK: - Service Call
    func getImage(from urlString: String) {
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
                    self?.image = UIImage(systemName: "photo.on.rectangle") ?? UIImage()
                    self?.isLoading = false
                }
                break
            }
        }
    }
}
