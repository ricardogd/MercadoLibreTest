//
//  ProductsListView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 17/04/21.
//

import SwiftUI

struct ProductsListView: View {
    var body: some View {
        
        VStack {
            Rectangle()
                .foregroundColor(.yellow)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 1)
            
            List {
                ForEach(0...3, id: \.self) { raw in
                    ProductListItem()
                }
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView()
    }
}
