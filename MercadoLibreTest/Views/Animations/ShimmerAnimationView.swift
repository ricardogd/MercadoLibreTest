//
//  ShimmerAnimationView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ShimmerAnimationView: View {
    
    @State private var animate: Bool = false
    var center = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.09))
//                .frame(height: 200)
                .cornerRadius(10)
            
            Rectangle()
                .foregroundColor(Color.white)
//                .frame(height: 200)
                .cornerRadius(10)
                .mask(
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, Color.white.opacity(0.60), .clear]), startPoint: .leading, endPoint: .trailing))
                        .offset(x: animate ? center : -center))
        }
        .onAppear {
            let baseAnimation = Animation.default.speed(0.18).delay(0)
            let repeatedAnimation = baseAnimation.repeatForever(autoreverses: false)
            withAnimation(repeatedAnimation) {
                animate.toggle()
            }
        }
    }
}

struct ShimmerAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerAnimationView()
    }
}
