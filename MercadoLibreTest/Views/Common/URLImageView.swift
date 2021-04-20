//
//  URLImage.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import SwiftUI

struct URLImageView: View {
    
    @StateObject var urlImageViewModel: URLImageViewModel
    
    var body: some View {
        
        if urlImageViewModel.isLoading {
            VStack {
                ShimmerAnimationView()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(10)
            }
        }
        else {
            VStack {
                Image(uiImage: urlImageViewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(10)
            }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlImageViewModel: URLImageViewModel(url: ""))
    }
}
