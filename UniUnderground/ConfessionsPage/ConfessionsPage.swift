//
//  ConfessionsPage.swift
//  UniUnderground
//
//  Created by Betty Demissie on 10/05/2023.
//

import SwiftUI

struct ConfessionsPage: View {
    @AppStorage("confession") var confession: String = ""
    @ObservedObject var viewModel:ConfessionsViewModel = ConfessionsViewModel()
    @State var selectedFilter = "All"
    @State var showFilter = false
    @State var searchUniversity: String = ""
    @State var confessionslist: [Confession] = []
    @State private var newComment: String = ""
    @AppStorage("profile")
    private var profileData:Data = Data()
    
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
                    if confessionslist.isEmpty{
                        Text("No Confessions")
                        
                    }else{
                        ForEach(confessionslist){ confession in
                            VStack{
                                HStack{
                                    Text(confession.text)
                                        .font(.custom("InriaSerif-Regular", size: 16))
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Text("\(confession.school)")
                                        .font(.custom("InriaSerif-Regular", size: 9))
                                        .foregroundColor(Color.gray)
                                }
                                .padding(.top, 1)
                            }
                            .padding(.bottom, 5)
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
                    addMessage()
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
        .onAppear{
            viewModel.fetchConfessions()
            viewModel.fetchSchools()
        }
        .onChange(of: selectedFilter, perform: { newValue in
            viewModel.changeSearchString(searchString: selectedFilter)
           confessionslist = viewModel.filterConfession()
        })
        .onChange(of: viewModel.confessions, perform: { newValue in
            confessionslist = viewModel.confessions
        })
        .onChange(of: viewModel.searchSchoolString) { newValue in
            viewModel.searchSchool()
        }
        .sheet(isPresented: $showFilter){
            
            VStack {
                Text("Select a school")
                    .padding(.trailing, 200)
                    .padding(.top)
                    .bold()
                    .font(.custom("Inter-Regular", size: 20))
                    .foregroundColor(Color.blackColor)
                
                TextField("Search your School", text: $viewModel.searchSchoolString)
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
                
                ForEach(viewModel.filteredschools, id: \.self) { option in
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
                
                Spacer()
            }
            .presentationDetents([.fraction(0.5), .medium])
            .presentationDragIndicator(.visible)
        }
    }
    
    func addMessage(){
        guard let profile = try? JSONDecoder().decode(UserProfile.self, from: profileData) else {
            return
        }
        
        if newComment != ""{
            viewModel.createConfession(confession: CreateConfession(text: newComment, school: profile.schoolname))
            newComment = ""
        }
    }
}


struct ConfessionsPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsPage()
    }
}

