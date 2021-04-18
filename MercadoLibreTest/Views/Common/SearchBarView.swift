//
//  SearchBar.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {

    //MARK: - Binding
    @Binding var text: String

    //MARK: - Required by UIViewRepresentable
    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = text
    }
    
    //Required to create the Coordinator in the current context
    func makeCoordinator() -> SearchBarView.Coordinator {
        return Coordinator(text: $text)
    }
    
    //MARK: - Coordinator
    //Coordinator class Allows the view to implement the UIKit delegates
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        SearchBarView(text: $text)
    }
}
