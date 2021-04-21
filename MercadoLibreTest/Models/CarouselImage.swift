//
//  CarouselImage.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation
import SwiftUI

struct CarouselImage: Identifiable {
    var id: UUID
    var image: UIImage
    
    init(image: UIImage) {
        self.id = UUID()
        self.image = image
    }
}
