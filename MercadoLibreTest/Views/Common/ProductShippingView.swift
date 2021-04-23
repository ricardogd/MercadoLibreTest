//
//  ProductShippingView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductShippingView: View {
    
    @State var shipping: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "airplane")
                .rotationEffect(Angle(degrees: -45))
                .foregroundColor(CustomColors.green)
            Text(shipping)
                .foregroundColor(CustomColors.green)
        }
        .padding(.top, 20)
    }
}

struct ProductShippingView_Previews: PreviewProvider {
    static var previews: some View {
        ProductShippingView(shipping: "Envío gratis")
    }
}
