//
//  SearchBar.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import SwiftUI

struct EventSearchBar: View {
    @Binding var text: String
    @State var searchicon = Image(systemName: "magnifyingglass")
    @State var micicon = Image(systemName: "mic.fill")
    
    var body: some View {
        HStack {

            TextField("\(searchicon)Search", text: $text)
                .padding(.horizontal)
                .frame(height: 40)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                )
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .opacity(0.2)// set the background color to secondary
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0)
                        )
                )
                .padding(.horizontal)
        }
    }
    
    struct EventSearchBar_Previews: PreviewProvider {
        static var previews: some View {
            EventSearchBar(text: .constant(""))
        }
    }
}
