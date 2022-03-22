//
//  ProductDetailView.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct ProductDetailView: View {
    
    @StateObject var productDetailVM: ProductDetailViewModel
    private let imageSize = UIScreen.main.bounds.width - 40
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(CustomColors.yellow)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 1)
            
            if productDetailVM.isLoading {
                VStack {
                    Spacer()
                    LoaderView()
                    Spacer()
                }
            }
            else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        TabView() {
                            ForEach(productDetailVM.detailImages, id: \.id) { image in
                                Image(uiImage: image.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: imageSize, height: imageSize, alignment: .center)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(width: imageSize, height: imageSize, alignment: .center)
                        
                        VStack(alignment: .leading) {
                            Text(productDetailVM.title)
                                .font(.title)
                                .padding(.top, 10)
                            Text(productDetailVM.originalProductPrice)
                                .strikethrough()
                                .background(CustomColors.lightGray)
                                .padding(.top, 10)
                            ProductPriceTextView(priceText: productDetailVM.productPrice, currencyText: "COP")
                            ProductInstallmentsView(payments: productDetailVM.productInstallments, interestRate: false)
                            ProductShippingView(shipping: productDetailVM.productShipping)
                            let descriptionVM = ProductDescriptionViewModel(withId: productDetailVM.productDescription)
                            ProductDescriptionView(descriptionVM: descriptionVM)
                        }
                    }
                }
                .padding()
            }
        }
        .alert(isPresented: $productDetailVM.showErrorAlert, content: {
            Alert(title: Text(Localization.localizedString(fromKey: "alert.error.title")),
                  message: Text(productDetailVM.errorMessage),
                  dismissButton: .default(Text(Localization.localizedString(fromKey: "alert.error.button"))))
        })
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    
    static let navController = UINavigationController()
    static let coordinator = HomeCoordinator(navigationController: navController)
    static let productDetailVM = ProductDetailViewModel(coordinator: coordinator, withProductId: "")
    
    static var previews: some View {
        ProductDetailView(productDetailVM: productDetailVM)
    }
}
