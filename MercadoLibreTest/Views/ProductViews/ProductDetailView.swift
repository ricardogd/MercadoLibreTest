//
//  ProductDetailView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct ProductDetailView: View {
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(CustomColors.yellow)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 1)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Image("CategoryPlaceHolder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading) {
                        ProductPriceTextView(priceText: "$ 10.000", currencyText: "COP")
                        .padding(.top, 10)
                        ProductInstallmentsView(payments: "12x $ 2.000", interestRate: false)
                        ProductShippingView(shipping: "Envío gratis")
                        ProductDescriptionView(description: "Product description detailed about the propreties, benefits, limitations and any other importatn information about the product that is being displayed in this detail screen")
                    }
                }
            }
            .padding()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
