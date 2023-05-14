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
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 344, height: 41, alignment: .leading)
                    
                    Rectangle()
                        .fill(Color.secondary)
                        .opacity(0.4)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.bottom)
                        
                      
                
                Button(action: { showFilter = true }) {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 31, height: 15)
                        .foregroundColor(.primary)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                VStack{
                    ForEach(confessionList()){ confession in
                        VStack{
                            Text(confession.text)
                                .font(.custom("InriaSerif-Regular", size: 16))
                            HStack{
                                Spacer()
                                Text("\(confession.school)")
                                    .font(.custom("InriaSerif-Regular", size: 9))
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }
            }
            
            HStack {
                VStack {
                    TextField("Type your confession", text: $newComment)
                        .padding(10)
                        .font(.custom("InriaSerif-Regular", size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 0.5)
                        ) .frame(width: 290, height: 45)
                       
                }
                .frame(height: 20)

                Button(action: {
                    let confession = Confession(text: newComment, school: "")
                    var confessions = confessionList()
                    confessions.append(confession)
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(confessions), forKey: "confessions")
                    newComment = ""
                }) {
                    ZStack{
                        Rectangle()
                            .fill(Color.blackColor)
                            .frame(width: 40, height: 40)
                            .cornerRadius(14)
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color.whiteColor)
                    }
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showFilter){
           
            VStack {
                Text("Select a school")
                    .padding(.trailing, 200)
                    .padding(.top)
                    .bold()
                    .font(.custom("Inter-Regular", size: 20))
                    .foregroundColor(Color.blackColor)
                
                TextField("Search your School", text: $searchUniversity)
                    .foregroundColor(.blackColor)
                    .font(.custom("InriaSerif-Regular", size: 16))
                    .padding()
                    .frame(width: 354, height: 44 ,alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Spacer()
            }
                .presentationDetents([.fraction(0.3), .medium])
                .presentationDragIndicator(.visible)
                
        }
                
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
    
    
    func confessionList() -> [Confession]{
        return [
            Confession(text: "I opened it and it was full of nail clippings. I put it back and never said anything. It was the weirdest thing I have ever seen!", school: "university of oxford")
            
        ]
    }

struct ConfessionsPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsPage()
    }
}

