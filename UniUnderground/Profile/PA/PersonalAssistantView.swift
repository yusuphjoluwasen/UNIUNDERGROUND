//
//  PersonalAssistantView.swift
//  UniUnderground
//
//  Created by Guru King on 14/05/2023.
//

import SwiftUI
import Lottie
import AVFoundation

struct PersonalAssistantView: View {
    let synthesizer = AVSpeechSynthesizer()
    @State var moveToPAMessagePage = false
    @State var name:String
    var body: some View {
        NavigationStack{
            VStack{
                LottieView(lottieFile: "76890-robot-assistant")
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 70)
                
                Button {
                   moveToPAMessagePage = true
                } label: {
                    ZStack{
                        Text("Continue")
                            .foregroundColor(Color.whiteColor)
                            .font(.custom("Inter-SemiBold", size: 17))
                            .padding(.trailing, 30)
                        
                        Image(systemName: "forward.end.circle.fill")
                            .padding(.leading, 90)
                            .foregroundColor(Color.whiteColor)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.blackColor)
                    .cornerRadius(15)
                    .padding()
                    
                }
            }
            .navigationTitle("Personal Assistant")
            .onAppear{
                speak()
            }
            .navigationDestination(isPresented: $moveToPAMessagePage, destination: {
               PAMessageView()
            })
           
        }
    }
    
    func speak(){
        let utterance = AVSpeechUtterance(string: "Hi \(name), My name is Tami, I am your personal assistant, How can i help you today?")
        synthesizer.speak(utterance)
    }
}

struct PersonalAssistantView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalAssistantView(name: "Christie")
    }
}
