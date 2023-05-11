//
//  ConfessionsPage.swift
//  UniUnderground
//
//  Created by Betty Demissie on 10/05/2023.
//

import SwiftUI

struct ConfessionsPage: View {
    @AppStorage("confession") var confession: String = ""
    @State var showConfession = false
    @State var selectedFilter = "All"
    @State var showFilter = false
    @State var searchUniversity: String = ""
    @EnvironmentObject var confessionsList: ConfessionsCommentsList
    @State private var newComment: String = ""
    let filterOptions = ["All", "University of Westminster", "University of Warwick", "University of Oxford", "Royal Holloway Unviersity"]
    
    var body: some View {
            VStack(alignment: .leading) {
                    Text("Confessions 🤫")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    
                    Button(action: { showFilter = true }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .popover(isPresented: $showFilter, arrowEdge: .bottom) {
                        VStack {
                        Text("Select a University")
                            TextField("Search a University", text: $searchUniversity)
                                .cornerRadius(20)
                                .frame(width: 400, height: 40 ,alignment: .center)
                                .border(Color.secondary)
                                .padding(.horizontal)
                            ForEach(filterOptions, id: \.self) { option in
                                Button(action: {
                                    selectedFilter = option
                                    showFilter = false
                                }) {
                                    HStack {
                                        Text(option)
                                            .foregroundColor(.primary)
                                            .padding(.leading, 10)
                                        Spacer()
                                        if selectedFilter == option {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.primary)
                                                .padding(.trailing, 10)
                                            
                                        }
                                    }
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                List{ ForEach(confessionsList.confessionsComments, id: \.self)
                    {
                        comment in Text(comment)
                    }
                    
                }.listStyle(InsetListStyle())
            
                HStack {
                    TextField("Type your confession", text: $newComment)
                        .cornerRadius(20)
                        .frame(width: 300, height: 40 ,alignment: .center)
                        .border(Color.secondary)
                        .padding(.horizontal)
                    
                    Button(action: {
                        confessionsList.addComment(comment: newComment)
                        newComment = ""
                    }) {
                        Image(systemName: "paperplane.circle.fill")
                            .scaledToFit()
                            .foregroundColor(.primary)
                            .frame(width: 50, height: 40, alignment: .center)
                            .background(Color.secondary)
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear{confessionsList.loadCommentsFromUserDefaults()}
        }
        }
    
    
    struct ConfessionsPage_Previews: PreviewProvider {
        static var previews: some View {
            ConfessionsPage(confession: "")
                .environmentObject(ConfessionsCommentsList())
        }
    }
    
