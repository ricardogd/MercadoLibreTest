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
    @State private var searchText : String = ""

    //MARK: - Content View
    var body: some View {
        VStack {
            //Search Bar
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColors.yellow, .white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 90)
                
                SearchBarView(text: $searchText, shouldSearchForPruduct: $productListViewModel.shouldSearchForProduct)
            }
            
            if productListViewModel.isLoading == true {
                //Loading Shimmer Animation
                List {
                    ForEach(0...1, id: \.self) { raw in
                        Text("Loading")
                            .frame(height: 200)
                    }
                }
                .padding(.bottom, 1)
            }
            else {
                //Categories List
                List {
                    ForEach(0...7, id: \.self) { raw in
                        ProductListItem(productItemViewModel: productListViewModel.productItemViewModel)
                            .onTapGesture {
                                productListViewModel.navigateToProduct()
                            }
                            .frame(height: 200)
                    }
                }
                .padding(.bottom, 1)
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    
    static let nav = UINavigationController()
    static let coor = HomeCoordinator(navigationController: nav)
    static let productViewModel = ProductListViewModel(coordinator: coor)
    
    static var previews: some View {
        ProductsListView(productListViewModel: productViewModel)
    }
}
