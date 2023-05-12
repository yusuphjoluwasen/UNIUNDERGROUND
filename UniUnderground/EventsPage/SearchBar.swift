//
//  SearchBar.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import SwiftUI

struct EventSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search events", text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}

struct EventSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        EventSearchBar(text: .constant(""))
    }
}
