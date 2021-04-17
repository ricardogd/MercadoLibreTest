//
//  CategoryListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct CategoryListItem: View {
    
    @State var text: String
    
    var body: some View {

        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(10)
                .padding(10)
                .frame(width: 150, height: 150)
                
            VStack {
                Text(text)
                    .font(.headline)
                Image("NoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
            .padding(.top, 10)
        }
    }
}

struct CategoryListItem_Previews: PreviewProvider {
    
    @State static var text: String = "Prueba"

    static var previews: some View {
        CategoryListItem(text: text)
    }
}
