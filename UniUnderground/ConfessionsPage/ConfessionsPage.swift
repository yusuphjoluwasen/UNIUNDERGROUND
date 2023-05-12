//
//  ConfessionsPage.swift
//  UniUnderground
//
//  Created by Betty Demissie on 10/05/2023.
//

import SwiftUI

struct ConfessionsPage: View {
    @AppStorage("confession") var confession: String = ""
    @State var selectedFilter = "All"
    @State var showFilter = false
    @State var searchUniversity: String = ""
    @State private var newComment: String = ""
    let filterOptions = ["All", "University of Westminster", "University of Warwick", "University of Oxford", "Royal Holloway Unviersity", ""]
    
    var body: some View {
        VStack {
            ScrollView{
                Text("Confessions 🤫")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                
                Button(action: { showFilter = true }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                VStack{
                    ForEach(confessionList()){ confession in
                        VStack{
                            Text(confession.text)
                            HStack{
                                Spacer()
                                Text(confession.school)
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField(" Type your confession", text: $newComment)
                    .cornerRadius(20)
                    .frame(width: 300, height: 40 ,alignment: .center)
                    .border(Color.secondary)
                    .padding(.horizontal)
                
                Button(action: {
                  //  confessionsList.addComment(comment: newComment)
                   // newComment = ""
                }) {
                    ZStack{
                        Rectangle()
                            .fill(Color.blackColor)
                            .frame(width: 44, height: 44)
                            .cornerRadius(14)
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color.whiteColor)
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear{}
        .popover(isPresented: $showFilter, arrowEdge: .bottom) {
            VStack {
                Text("Select a University")
                TextField("Search a University", text: $searchUniversity)
                    .cornerRadius(20)
                    .frame(width: 400, height: 40 ,alignment: .center)
                    .border(Color.secondary)
                    .padding(.horizontal)
//                ForEach(filterOptions, id: \.self) { option in
//                    Button(action: {
//                        selectedFilter = option
//                        showFilter = false
//                    }) {
//                        HStack {
//                            Text(option)
//                                .foregroundColor(.primary)
//                                .padding(.leading, 10)
//                            Spacer()
//                            if selectedFilter == option {
//                                Image(systemName: "checkmark")
//                                    .foregroundColor(.primary)
//                                    .padding(.trailing, 10)
//
//                            }
//                        }
//                        .padding(.vertical, 10)
//                    }
                }
            }
    }
    
    func confessionList() -> [Confession]{
        return [
            Confession(text: "I opened it and it was full of nail clippings. I put it back and never said anything. It was the weirdest thing I have ever seen!", school: "university of oxford")
            
        ]
    }
}


struct ConfessionsPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsPage()
    }
}

