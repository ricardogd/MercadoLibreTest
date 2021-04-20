//
//  ProductListAnimationView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ProductListAnimationView: View {
        
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(CustomColors.lightGray)
                    .frame(width: geometry.size.width, height: 180)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                HStack() {
                    //Iimage animation
                    VStack(alignment: .leading) {
                        ShimmerAnimationView()
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                    .padding(.leading, 10)
                        
                    //Labels
                    VStack(alignment: .leading) {
                        ShimmerAnimationView()
                            .frame(width: 200, height: 20, alignment: .center)
                        ShimmerAnimationView()
                            .frame(width: 200, height: 20, alignment: .center)
                        ShimmerAnimationView()
                            .frame(width: 200, height: 20, alignment: .center)
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                }
                .frame(height: 180)
            }
        }
    }
}

struct ProductListAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListAnimationView()
    }
}
