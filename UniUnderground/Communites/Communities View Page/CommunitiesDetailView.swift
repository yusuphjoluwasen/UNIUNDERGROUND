//
//  CommunitiesDetailView.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct CommunitiesDetailView: View {
    var community: Community?
    @State private var newComment: String = ""
    @State private var firstname: String = ""
    @ObservedObject var viewModel:CommunitiesViewModel = CommunitiesViewModel()
    @AppStorage("profile")
    private var profileData:Data = Data()

    var body: some View {
        VStack {
            Text(community?.groupname ?? "")
                .font(.custom("Inter-Bold", size: 34))
            Divider()

            List {
                ForEach(viewModel.messages) { chat in
                    VStack{
                        if chat.userfirstname == firstname{
                            ChatBubble(position: .right, color: .blue) {
                                VStack{
                                    HStack{
                                        Text(chat.userfirstname)
                                            .font(.custom("InriaSerif-Regular", size: 9))
                                        Spacer()
                                        Text("2023-03-12")
                                            .font(.custom("InriaSerif-Regular", size: 9))
                                    }
                                    HStack{
                                        Text(chat.text)
                                            .font(.custom("Inter-Medium", size: 14))
                                        Spacer()
                                    }
                                }
                            }
                           
                        }else{
                            ChatBubble(position: .left, color: .gray) {
                                VStack{
                                    HStack{
                                        Text(chat.userfirstname)
                                            .font(.custom("InriaSerif-Regular", size: 9))
                                        Spacer()
                                        Text("2023-03-12")
                                            .font(.custom("InriaSerif-Regular", size: 9))
                                    }
                                    HStack{
                                        Text(chat.text)
                                            .font(.custom("Inter-Medium", size: 14))
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .foregroundColor(Color.whiteColor)
                }
            }
            .listStyle(InsetListStyle())

            VStack {
                HStack {
                    TextField(" Type a message", text: $newComment)
                        .frame(height: 45)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    Button(action: {
                        addMessage()
                        
                    }, label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.blackColor)
                                .frame(width: 40, height: 40)
                                .cornerRadius(14)
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(Color.whiteColor)
                        }
                    })
                }
                .padding(.horizontal)
                .background(Color.white)
            }
        }
        .onAppear {
            viewModel.fetchCommunityMessages(communityid: community?.id ?? "")
            loadFromAppStorage()
        }
    }
    
    func addMessage(){
        guard let profile = try? JSONDecoder().decode(UserProfile.self, from: profileData) else {
            return
        }
        
        if newComment != ""{
            viewModel.addToCommunityMessages(text: newComment, communityid: community?.id ?? "",firstname: profile.firstname, lastname: profile.lastname, school: profile.schoolname)
            newComment = ""
        }
    }
    
    func loadFromAppStorage(){
        guard let profile = try? JSONDecoder().decode(UserProfile.self, from: profileData) else {
            return
        }
        print("firstname", profile.firstname.capitalized)
        firstname = profile.firstname.capitalized
    }
}




struct CommunitiesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesDetailView(community:Community(groupname: "group", grouplogo: "logo", description: "description", user: "user"))
    }
}




struct ChatBubble<Content>: View where Content: View {
    let position: BubblePosition
    let color : Color
    let content: () -> Content
    init(position: BubblePosition, color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.color = color
        self.position = position
    }
    
    var body: some View {
        HStack(spacing: 0 ) {
            content()
                .padding(.all, 15)
                .foregroundColor(Color.white)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    Image(systemName: "arrowtriangle.left.fill")
                        .foregroundColor(color)
                        .rotationEffect(Angle(degrees: position == .left ? -50 : -130))
                        .offset(x: position == .left ? -5 : 5)
                    ,alignment: position == .left ? .bottomLeading : .bottomTrailing)
        }
        .padding(position == .left ? .leading : .trailing , 15)
        .padding(position == .right ? .leading : .trailing , 60)
        .frame(width: UIScreen.main.bounds.width, alignment: position == .left ? .leading : .trailing)
    }
}

enum BubblePosition {
    case left
    case right
}

