//
//  URLImageViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

class URLImageViewModel: ObservableObject {
    
    @Published var shouldShowPlaceHolder = true
    @Published var imageData = Data()
    
    var urlString: String
    
    init(url: String) {
        self.urlString = url
        getImageFromUrl()
    }
    
    func getImageFromUrl() {
        //TODO: Call service and return imageData
    }
}
