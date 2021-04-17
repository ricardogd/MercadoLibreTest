//
//  ProductListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct ProductListItem: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 200)
                .cornerRadius(10)
                .padding(10)
            
            HStack() {
                
                VStack(alignment: .leading) {
                    Image("NoImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150, alignment: .center)
                        .cornerRadius(10)
                }
                .padding(.leading, 25)
                                                
                VStack(alignment: .leading) {
                    Text("Product Name")
                        .padding(.top, 5)
                    Text("Product Price")
                        .padding(.top, 5)
                    Text("Payments")
                        .padding(.top, 5)
                    Text("Discount")
                        .padding(.top, 5)
                }
                .padding(.leading, 5)
                
                Spacer()
                
            }
            .frame(height: 190)
        }
    }
}

struct ProductListItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductListItem()
    }
}
