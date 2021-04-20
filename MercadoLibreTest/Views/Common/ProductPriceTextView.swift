//
//  PrductPriceTextView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductPriceTextView: View {
    
    @State var priceText: String = ""
    @State var currencyText: String = ""
    
    var body: some View {
        HStack {
            Text(priceText)
                .font(.title)
                .padding(.top, 5)
            Text(currencyText)
                .font(.system(size: 14))
                .padding(.top, 5)
                .foregroundColor(CustomColors.green)
        }
    }
}

struct ProductPriceTextView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPriceTextView(priceText: "$ 10.000", currencyText: "COP")
    }
}
