//
//  ProductListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct ProductListItem: View {
    
    @StateObject var productItemViewModel: ProductItemViewModel
    
    var body: some View {
        
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(CustomColors.lightGray)
                    .frame(width: geometry.size.width, height: 180)
                    .cornerRadius(10)
//                    .padding(10)
                
                HStack() {
                    //Loading image animation - image place holder - product image
                    VStack(alignment: .leading) {
                        URLImage(urlImageViewModel: productItemViewModel.productImage)
                    }
                    .padding(.leading, 25)
                        
                    //Product labels
                    VStack(alignment: .leading) {
                        Text("Product \nTitle")
                            .padding(.top, 5)
                        HStack {
                            Text("Product Price")
                                .font(.title)
                                .padding(.top, 5)
                            Text("COL")
                                .padding(.top, 5)
                        }
                        HStack {
                            Text("en")
                                .padding(.top, 5)
                            Text("12x $20000")
                                .padding(.top, 5)
                            Text("sin interés")
                                .padding(.top, 5)
                        }
                        Text("Shipping")
                            .padding(.top, 5)
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(height: 200)
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
