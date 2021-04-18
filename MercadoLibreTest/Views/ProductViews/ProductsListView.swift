//
//  ProductsListView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 17/04/21.
//

import SwiftUI

struct ProductsListView: View {
    
    @State private var searchText : String = ""
    
    //TODO: Refactor this
    @StateObject var productItemViewModel: ProductItemViewModel
    
    var body: some View {
        VStack {
            //Search Bar
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColors.yellow, .white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 90)
                
                SearchBar(text: $searchText)
            }
            
            //Categories List
            List {
                ForEach(0...7, id: \.self) { raw in
                    ProductListItem(productItemViewModel: productItemViewModel)
                        .onTapGesture {
                            productItemViewModel.navigateToProduct()
                        }
                        .frame(height: 180)
                }
            }
            .padding(.bottom, 1)
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    
    static let nav = UINavigationController()
    static let coor = HomeCoordinator(navigationController: nav)
    static let productViewModel = ProductItemViewModel(coordinator: coor)
    
    static var previews: some View {
        ProductsListView(productItemViewModel: productViewModel)
    }
}
