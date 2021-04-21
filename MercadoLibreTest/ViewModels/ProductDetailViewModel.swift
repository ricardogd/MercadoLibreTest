//
//  ProductDetailViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation
import Combine
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    
    //MARK: - Published Variables
    @Published var isLoading: Bool = false
    @Published var detailImages: [CarouselImage] = [CarouselImage(image: UIImage(named: "CategoryPlaceHolder") ?? UIImage())]
    @Published var title: String = ""
    @Published var originalProductPrice: String = ""
    @Published var productPrice: String = ""
    @Published var productCurrency: String = ""
    @Published var productInstallments: String = ""
    @Published var hasInterestRate: Bool = true
    @Published var productShipping: String = ""
    @Published var productDescription: String = ""
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    let serviceProvider = ServiceProvider.productDetailClient
    var productDetail: ProductDetail?

    //MARK: - Constructor
    init(coordinator: HomeCoordinator, withProductId id: String) {
        self.coordinator = coordinator
        self.isLoading = true
        getProductDetail(productId: id)
    }
    
    //MARK: - Service Calls
    func getProductDetail(productId: String) {
        serviceProvider.getProductDetail(forProduct: productId) { [weak self] (result) in
            switch result {
            case .success(let productDetail):
                self?.productDetail = productDetail
                self?.getProductImages(detailImages: productDetail.detailImages)
                break
                
            case .failure(_):
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                break
            }
        }
    }

    func getProductImages(detailImages: [DetailImage]) {
        let serviceProvider = ServiceProvider.getImageClient
        let dispatchGroup = DispatchGroup()
        var images: [CarouselImage] = []
        
        for image in detailImages {
            dispatchGroup.enter()
            
            serviceProvider.getImage(fromURL: image.secureUrl) { (result) in
                switch result {
                case .success(let data):
                    let newImage = UIImage(data: data) ?? UIImage(named: "CategoryPlaceHolder") ?? UIImage()
                    let imageTest = CarouselImage(image: newImage)
                    images.append(imageTest)
                    dispatchGroup.leave()
                    break
                    
                case .failure(_):
                    let newImage = UIImage(named: "CategoryPlaceHolder") ?? UIImage()
                    let imageTest = CarouselImage(image: newImage)
                    images.append(imageTest)
                    dispatchGroup.leave()
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            if let productDetail = self.productDetail {
                DispatchQueue.main.async {
                    self.detailImages = images
                    self.title = productDetail.title
                    self.setOriginalProductPrice(price: productDetail.originalPrice ?? 0.0)
                    self.setProductPrice(price: productDetail.price, currency: productDetail.currency)
                    //Service is not retrieving the installments object for the detail service call, setting this to nil adds default values
                    self.setProductInstallments(installment: nil)
                    self.setProductShipping(isFreeShipping: productDetail.shipping.freeShipping)
                    self.productDescription = productDetail.id
                    self.isLoading = false
                }
            }
        }
    }
    
    //MARK: - UI
    func setOriginalProductPrice(price: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if price > 0.0 {
            originalProductPrice = formatter.string(from: NSNumber(value: price)) ?? "$ 0.00"
        }
        else {
            originalProductPrice = ""
        }
    }
    
    func setProductPrice(price: Double, currency: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        productPrice = formatter.string(from: NSNumber(value: price)) ?? "$ 0.00"
        productCurrency = currency
    }
    
    func setProductInstallments(installment: Installment?) {
        let numberOfPayments = installment?.quantity ?? 0
        let amount = installment?.amount ?? 0.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amountStrig = formatter.string(from: NSNumber(value: amount)) ?? "$ 0.00"
        
        productInstallments = String(numberOfPayments) + "x " + amountStrig
        hasInterestRate = installment?.rate ?? 1 == 0 ? false : true
    }
    
    func setProductShipping(isFreeShipping: Bool) {
        if isFreeShipping {
            productShipping = "Envío gratis"
        }
        else {
            productShipping = "No incluye el envío"
        }
    }
}
