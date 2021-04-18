//
//  AboutView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import SwiftUI

struct AboutView: View {
    let options = ["Desarrollado por", "Prueba", "Versión", "otros"]
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.yellow)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 100)
                
            }.padding(.bottom)
                        
            VStack {
                List {
                    ForEach(self.options, id: \.self) { option in
                        HStack {
                            Text(option)
                            Text(": Test")
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
