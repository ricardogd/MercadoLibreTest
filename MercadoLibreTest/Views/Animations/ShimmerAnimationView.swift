//
//  ShimmerAnimationView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct ShimmerAnimationView: View {
    
    //MARK: - States
    @State private var animate: Bool = false
    var center = UIScreen.main.bounds.width / 2
    
    //MARK: - Content view
    var body: some View {
        ZStack {
            //These two rectangles create the background and combinated shows the right color for animation
            Rectangle()
                .foregroundColor(Color.black.opacity(0.09))
                .cornerRadius(10)
            
            Rectangle()
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .mask(
                    //This mask rectangle with linear gradient creates the light effect that will be animated
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, Color.white.opacity(0.60), .clear]), startPoint: .leading, endPoint: .trailing))
                        //The animation consists of moving the gradient through its container left to right
                        .offset(x: animate ? center : -center))
        }
        .onAppear {
            //Setting the animation speed and loop
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
