//
//  ProductsListView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 17/04/21.
//

import SwiftUI

struct ProductsListView: View {
    
    //MARK: - States
    @StateObject var productListViewModel: ProductListViewModel

    //MARK: - Content View
    var body: some View {
        VStack {
            //Search Bar
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColors.yellow, .white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 90)
                
                
                SearchBarView(text: $productListViewModel.searchText, shouldSearchForPruduct: $productListViewModel.shouldSearchForProduct)
            }
            
            if productListViewModel.isLoading == true {
                //Loading Shimmer Animation
                ScrollView {
                    VStack {
                        ForEach(0...1, id: \.self) { raw in
                            ProductListAnimationView()
                                .frame(height: 180)
                                .padding()
                        }
                    }
                }
                .padding(.bottom, 1)
            }
            else {
                //Products List
                ScrollView {
                    LazyVStack {
                        ForEach(productListViewModel.products, id: \.id) { product in
                            let productItemViewModel = ProductItemViewModel(product: product)
                            ProductListItem(productItemViewModel: productItemViewModel)
                                .onTapGesture {
                                    productListViewModel.navigateToProduct(withProductId: product.id)
                                }
                                .frame(height: 180)
                                .padding()
                        }
                    }
                }
                .padding(.bottom, 1)
            }
        }
        .alert(isPresented: $productListViewModel.showErrorAlert, content: {
            Alert(title: Text(Localization.localizedString(fromKey: "alert.error.title")),
                  message: Text(productListViewModel.errorMessage),
                  dismissButton: .default(Text(Localization.localizedString(fromKey: "alert.error.button"))))
        })
    }
}

struct ProductsListView_Previews: PreviewProvider {
    
    static let nav = UINavigationController()
    static let coor = HomeCoordinator(navigationController: nav)
    static let productViewModel = ProductListViewModel(coordinator: coor, withCategoryId: "")
    
    static var previews: some View {
        ProductsListView(productListViewModel: productViewModel)
    }
}
