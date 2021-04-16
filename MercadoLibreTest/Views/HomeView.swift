//
//  HomeView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import SwiftUI

struct HomeView: View {
    
    let categories = ["Comida", "Autos", "Tec", "Ropa"]
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.yellow)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 100)
                
                Text("Search Product")
                    .background(Rectangle().foregroundColor(.white))
                    .cornerRadius(3.0)
            }.padding(.bottom)
                        
            VStack {
                List {
                    ForEach(self.categories, id: \.self) { category in
                        Text(category)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
