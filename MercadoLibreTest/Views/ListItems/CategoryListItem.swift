//
//  CategoryListItem.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct CategoryListItem: View {
    
    //MARK: - States
    @StateObject var categoryListItemVM: CategoryListItemViewModel
    
    //MARK: - Content View
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Rounded Category Image
                Image(uiImage: categoryListItemVM.image)
                    .resizable()
                    .frame(width: abs(geometry.size.width - 20), height: categoryListItemVM.listItemHeight)
                    .aspectRatio(contentMode: .fill)
                    .background(CustomColors.lightGray)
                    .cornerRadius(20)
                    .shadow(radius: 5)
       
                //Category Title
                VStack {
                    HStack {
                        Text(categoryListItemVM.name)
                            .font(.title).bold()
                            .background(CustomColors.lightGray)
                            .cornerRadius(5)
                        Spacer()
                    }
                    .padding(20)
                    Spacer()
                }
                .frame(height: categoryListItemVM.listItemHeight)
            }
        }
    }
}

struct CategoryListItem_Previews: PreviewProvider {
    
    static var categoryDetail = CategoryDetail()
    static var categoryDetailVM = CategoryListItemViewModel(categoryDetail: categoryDetail)

    static var previews: some View {
        CategoryListItem(categoryListItemVM: categoryDetailVM)
    }
}
