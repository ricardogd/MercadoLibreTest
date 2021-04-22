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

    //MARK: - Content View
    var body: some View {
        VStack {
            //Search Bar
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColors.yellow, .white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 90)
                
                SearchBarView(text: $homeViewModel.searchText, shouldSearchForPruduct: $homeViewModel.shouldSearchForProduct)
            }
            
            if homeViewModel.isLoading {
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
            else if homeViewModel.showProductList {
                //Products List
                ScrollView {
                    VStack {
                        ForEach(homeViewModel.products, id: \.id) { product in
                            let productItemViewModel = ProductItemViewModel(product: product)
                            ProductListItem(productItemViewModel: productItemViewModel)
                                .onTapGesture {
                                    homeViewModel.navigateToProduct(withProductId: product.id)
                                }
                                .frame(height: 180)
                                .padding()
                        }
                    }
                }
                .padding(.bottom, 1)
            }
            else {
                //Categories List
                ScrollView {
                    VStack {
                        ForEach(homeViewModel.categories, id: \.id) { category in
                            let categoryListItemVM = CategoryListItemViewModel(categoryDetail: category)
                            CategoryListItem(categoryListItemVM: categoryListItemVM)
                                .onTapGesture {
                                    homeViewModel.navigateToCategory(withCategoryId: category.id)
                                }
                                .id(UUID())
                                .frame(height: categoryListItemVM.listItemHeight)
                                .padding(.leading, 15)
                                .padding(.trailing, 15)
                                .padding(.bottom, 25)
                        }
                    }
                }
                .padding(.bottom, 1)
            }
        }
        .alert(isPresented: $homeViewModel.showErrorAlert, content: {
            Alert(title: Text(Localization.localizedString(fromKey: "alert.error.title")),
                  message: Text(homeViewModel.errorMessage),
                  dismissButton: .default(Text(Localization.localizedString(fromKey: "alert.error.button"))))
        })
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
