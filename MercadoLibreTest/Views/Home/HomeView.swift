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
                    ForEach(0...7, id: \.self) { raw in
                        ProductListItem(productItemViewModel: homeViewModel.productItemViewModel)
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
                    ForEach(homeViewModel.categories, id: \.self) { category in
                        CategoryListItem(text: category, listItemHeight: homeViewModel.getCategoryListItemHeight())
                            .onTapGesture {
                                homeViewModel.navigateToCategory()
                            }
                            .id(UUID())
                            .frame(height: homeViewModel.getCategoryListItemHeight())
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
