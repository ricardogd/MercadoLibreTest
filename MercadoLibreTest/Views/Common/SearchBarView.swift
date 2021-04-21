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
    @Binding var shouldSearchForPruduct: Bool

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
        return Coordinator(searchBarView: self)
    }
    
    //MARK: - Coordinator
    //Coordinator class Allows the view to implement the UIKit delegates
    class Coordinator: NSObject, UISearchBarDelegate {

        let searchBarView: SearchBarView

        init(searchBarView: SearchBarView) {
            self.searchBarView = searchBarView
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBarView.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBarView.text = searchBar.text ?? ""
            searchBarView.shouldSearchForPruduct = true
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var shouldSearchForPruduct = false

    static var previews: some View {
        SearchBarView(text: $text, shouldSearchForPruduct: $shouldSearchForPruduct)
    }
}
