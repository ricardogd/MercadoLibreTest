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
                
                SearchBar(text: $searchText)
            }
            
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

struct HomeView_Previews: PreviewProvider {
    
    static let navController = UINavigationController()
    static let homeCoordinator = HomeCoordinator(navigationController: navController)
    static let homeVM = HomeViewModel(coordinator: homeCoordinator)
    
    static var previews: some View {
        HomeView(homeViewModel: homeVM)
    }
}
