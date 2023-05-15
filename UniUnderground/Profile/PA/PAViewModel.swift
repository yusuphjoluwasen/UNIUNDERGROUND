//
//  PAViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 14/05/2023.
//

import Foundation
import Combine
import ChatGPTSwift

enum MessageOwner:String{
    case user, assistant
}

struct PaChatMessage:Identifiable{
    var id = UUID().uuidString
    var owner:MessageOwner
    var text:String
    
    init(owner: MessageOwner = .user, text: String) {
        self.owner = owner
        self.text = text
    }
}

@MainActor
class PAViewModel:ObservableObject{
    
    let api = ChatGPTAPI(apiKey: "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")
    
    @Published var message = ""
    @Published var chatMessages = [PaChatMessage]()
    @Published var isWaitingForResponse = false
    
    func sendMessage() async throws{
        let userMessage = PaChatMessage(text: message)
        chatMessages.append(userMessage)
        isWaitingForResponse = true
        
        //fetch
        let assistantMessage = PaChatMessage(owner: .assistant, text: "")
        chatMessages.append(assistantMessage)
        
        let stream = try await api.sendMessageStream(text: message)
        message = ""
        for try await line in stream{
            if let lastMessage = chatMessages.last{
                let text = lastMessage.text
                let newMessage = PaChatMessage(owner: .assistant, text: text + line)
                chatMessages[chatMessages.count - 1] = newMessage
            }
        }
        
        isWaitingForResponse = false
    }
    
}
