//
//  AboutView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import SwiftUI

struct AboutView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColors.yellow, .white]), startPoint: .center, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 90)
                
            }.padding(.bottom)
                        
            VStack {
                List {
                    HStack {
                        Text("Test Mercado Libre:")
                            .bold()
                        Text("Mobile iOS Dev")
                    }
                    HStack {
                        Text("Versión:")
                            .bold()
                        Text(appVersion ?? "N/A")
                    }
                    HStack {
                        Text("Desarrollado por:")
                            .bold()
                        Text("Ricardo Grajales")
                    }
                    HStack {
                        Text("FeedBack:")
                            .bold()
                        Text("ricardo.grajales21@gmail.com")
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
