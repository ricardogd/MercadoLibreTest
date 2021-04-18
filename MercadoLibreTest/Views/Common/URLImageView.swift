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
        
        if urlImageViewModel.shouldShowPlaceHolder {
            VStack {
                Image(systemName: "photo.on.rectangle")
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
