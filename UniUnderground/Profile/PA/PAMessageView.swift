//
//  PAMessageView.swift
//  UniUnderground
//
//  Created by Guru King on 14/05/2023.
//

import SwiftUI

struct PAMessageView: View {
    @ObservedObject private var viewModel = PAViewModel()
    var body: some View {
        VStack{
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.chatMessages) { message in
                            messageView(message)
                        }
                        
                        Color.clear
                            .frame(height: 1)
                            .id("bottom")
                    }
                }
                .onReceive(viewModel.$chatMessages.throttle(for: 0.5, scheduler: RunLoop.main, latest: true)) { chatMessages in
                    guard !chatMessages.isEmpty else { return }
                    withAnimation {
                        proxy.scrollTo("bottom")
                    }
                }
            }
            
            HStack{
                TextField("Message....", text: $viewModel.message, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                if viewModel.isWaitingForResponse{
                    ProgressView()
                        .padding()
                }else{
                    Button("Send") {
                        sendMessage()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    func messageView(_ message:PaChatMessage) -> some View{
        HStack{
            if message.owner == .user{
                Spacer(minLength: 60)
            }
            
            if !message.text.isEmpty{
                VStack{
                    Text(message.text)
                        .foregroundColor(message.owner == .user ? .whiteColor : .blackColor)
                        .padding(12)
                        .background(message.owner == .user ? .blue : .gray.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(alignment: message.owner == .user ? .topLeading : .topLeading) {
                            Text(message.owner.rawValue.capitalized)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .offset(y:-16)
                        }
                }
            }
            
            if message.owner == .assistant{
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal)
    }
    
    func sendMessage(){
        Task{
            do{
                try await viewModel.sendMessage()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct PAMessageView_Previews: PreviewProvider {
    static var previews: some View {
        PAMessageView()
    }
}
