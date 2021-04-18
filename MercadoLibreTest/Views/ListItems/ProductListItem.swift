//
//  ProductListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct ProductListItem: View {
    
    //MARK: - States
    @StateObject var productItemViewModel: ProductItemViewModel
    
    //MARK: - Content View
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(CustomColors.lightGray)
                    .frame(width: geometry.size.width, height: 180)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                HStack() {
                    //Loading image animation - image place holder - product image
                    VStack(alignment: .leading) {
                        URLImageView(urlImageViewModel: productItemViewModel.productImage)
                    }
                    .padding(.leading, 10)
                        
                    //Product labels
                    VStack(alignment: .leading) {
                        Text(productItemViewModel.productTitle)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        ProductPriceTextView(priceText: productItemViewModel.productPrice, currencyText: productItemViewModel.productCurrency)
                        ProductInstallmentsView(payments: productItemViewModel.productInstallments, interestRate: productItemViewModel.hasInterestRate)
                        Text(productItemViewModel.productShipping)
                            .foregroundColor(CustomColors.green)
                            .padding(.top, 5)
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                }
                .frame(height: 180)
            }
        }
    }
}

struct ProductListItem_Previews: PreviewProvider {
    
    static let navController = UINavigationController()
    static let homeCoordinator = HomeCoordinator(navigationController: navController)
    static let productItemViewModel = ProductItemViewModel(coordinator: homeCoordinator)
    
    static var previews: some View {
        ProductListItem(productItemViewModel: productItemViewModel)
    }
}
