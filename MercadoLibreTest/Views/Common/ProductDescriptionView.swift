//
//  ProductDescriptionView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductDescriptionView: View {
    
    @StateObject var descriptionVM: ProductDescriptionViewModel
    
    var body: some View {
        
        if descriptionVM.isLoading {
            VStack(alignment: .leading) {
                ShimmerAnimationView()
                    .frame(width: 200, height: 30, alignment: .center)
                    .cornerRadius(10)
                    .padding(.top, 10)
                ShimmerAnimationView()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 120, alignment: .center)
                    .cornerRadius(10)
            }
        }
        else {
            VStack(alignment: .leading) {
                Text("Descripción")
                    .bold()
                    .padding(.bottom, 5)
                Text(descriptionVM.description)
            }
            .padding(.top, 20)
        }
    }
}

struct ProductDescriptionView_Previews: PreviewProvider {
    
    static let descriptionVM = ProductDescriptionViewModel(withId: "")
    
    static var previews: some View {
        ProductDescriptionView(descriptionVM: descriptionVM)
    }
}
