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
                        Text(Localization.localizedString(fromKey: "information.placeholder.name"))
                            .bold()
                        Text(Localization.localizedString(fromKey: "information.value.name"))
                    }
                    HStack {
                        Text(Localization.localizedString(fromKey: "information.placeholder.version"))
                            .bold()
                        Text(appVersion ?? "N/A")
                    }
                    HStack {
                        Text(Localization.localizedString(fromKey: "information.placeholder.developer"))
                            .bold()
                        Text(Localization.localizedString(fromKey: "information.value.developer"))
                    }
                    HStack {
                        Text(Localization.localizedString(fromKey: "information.placeholder.feedback"))
                            .bold()
                        Text(Localization.localizedString(fromKey: "information.value.feedback"))
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
