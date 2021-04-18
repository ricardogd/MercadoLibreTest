//
//  CategoryListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct CategoryListItem: View {
    
    //MARK: - States
    @State var text: String = ""
    @State var listItemHeight: CGFloat = 0
    
    //MARK: - Content View
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Rounded Category Image
                Image("CategoryPlaceHolder")
                    .resizable()
                    .frame(width: geometry.size.width - 20, height: listItemHeight)
                    .aspectRatio(contentMode: .fill)
                    .background(CustomColors.lightGray)
                    .cornerRadius(20)
                    .shadow(radius: 5)
       
                //Category Title
                VStack {
                    HStack {
                        Text(text)
                            .font(.title).bold()
                        Spacer()
                    }
                    .padding(20)
                    Spacer()
                }
                .frame(height: listItemHeight)
            }
        }
    }
}

struct CategoryListItem_Previews: PreviewProvider {
    
    @State static var text: String = "Texto de Prueba Número Uno"

    static var previews: some View {
        CategoryListItem(text: text, listItemHeight: 375)
    }
}
