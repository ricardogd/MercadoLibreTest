//
//  LoaderView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var isLoading = false
    @State var degress = 0.0
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(isLoading ? CustomColors.blue : CustomColors.yellow, lineWidth: 5.0)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: degress))
                .onAppear() {
                    self.startAnimating()
                }
            Text(Localization.localizedString(fromKey: "animation.loading.placeholder"))
                .padding()
        }
    }
    
    func startAnimating() {
        
        //Times needed to set the speed of the animation
        _ = Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer in
            withAnimation {
                self.degress += 10.0
            }
            
            //Toggle values for each iteration 
            if self.degress == 360.0 {
                self.degress = 0.0
                self.isLoading.toggle()
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
