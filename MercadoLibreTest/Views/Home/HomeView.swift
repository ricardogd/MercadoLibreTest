//
//  HomeView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - States
    @StateObject var homeViewModel: HomeViewModel
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
                
                SearchBarView(text: $searchText, shouldSearchForPruduct: $homeViewModel.shouldSearchForProduct)
            }
            
            if homeViewModel.isLoading {
                //Loading Shimmer Animation
                List {
                    ForEach(0...1, id: \.self) { raw in
                        ProductListAnimationView()
                            .frame(height: 200)
                    }
                }
                .padding(.bottom, 1)
            }
            else if homeViewModel.showProductList {
                //Products List
                List {
                    ForEach(homeViewModel.products, id: \.id) { product in
                        let productItemViewModel = ProductItemViewModel(product: product)
                        ProductListItem(productItemViewModel: productItemViewModel)
                            .onTapGesture {
                                homeViewModel.navigateToProduct()
                            }
                            .frame(height: 200)
                    }
                }
                .padding(.bottom, 1)
            }
            else {
                //Categories List
                List {
                    ForEach(homeViewModel.categories, id: \.id) { category in
                        let categoryListItemVM = CategoryListItemViewModel(categoryDetail: category)
                        CategoryListItem(categoryListItemVM: categoryListItemVM)
                            .onTapGesture {
                                homeViewModel.navigateToCategory(withCategoryId: category.id)
                            }
                            .id(UUID())
                            .frame(height: categoryListItemVM.listItemHeight)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.bottom, 1)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static let navController = UINavigationController()
    static let homeCoordinator = HomeCoordinator(navigationController: navController)
    static let homeVM = HomeViewModel(coordinator: homeCoordinator)
    
    static var previews: some View {
        HomeView(homeViewModel: homeVM)
    }
}
