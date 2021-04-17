//
//  HomeView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var searchText : String = ""
    
    //TODO: Remove this when linking the data
    let categories = ["Comida", "Autos", "Tec", "Ropa", "Cosmeticos", "Conectividad", "TVs", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 100)
                
                SearchBar(text: $searchText)
            }
                        
            VStack {
                List {
                    ForEach(self.categories, id: \.self) { category in
                        CategoryListItem(text: category)
                            .onTapGesture {
                                homeViewModel.navigateTo()
                            }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel:
                    HomeViewModel(coordinator:
                                    HomeCoordinator(navigationController:
                                                        UINavigationController())))
    }
}
