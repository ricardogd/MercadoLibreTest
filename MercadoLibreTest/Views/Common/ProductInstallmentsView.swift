//
//  ProductInstallments.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductInstallmentsView: View {
    
    @State var payments: String = ""
    @State var interestRate: Bool = false
    
    var body: some View {
        HStack {
            Text(Localization.localizedString(fromKey: "product.installment.placeholder"))
                .font(.system(size: 14))
            Text(payments)
                .font(.system(size: 14))
                .foregroundColor(CustomColors.green)
            Text(interestRate ? "": Localization.localizedString(fromKey: "product.installment.rate"))
                .font(.system(size: 14))
                .foregroundColor(CustomColors.green)
        }
    }
}

struct ProductInstallmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInstallmentsView(payments: "12x $ 2.000", interestRate: false)
    }
}
