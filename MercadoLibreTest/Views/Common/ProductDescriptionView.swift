//
//  ProductDescriptionView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductDescriptionView: View {
    
    @State var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Descripción")
                .bold()
                .padding(.bottom, 5)
            Text(description)
        }
        .padding(.top, 20)
    }
}

struct ProductDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDescriptionView(description: "Product description detailed about the propreties, benefits, limitations and any other importatn information about the product that is being displayed in this detail screen")
    }
}
