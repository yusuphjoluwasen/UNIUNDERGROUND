//
//  SelectSchools.swift
//  UniUnderground
//
//  Created by Guru King on 10/05/2023.
//

import SwiftUI
import AVFoundation

struct SelectSchool: View {
    let synthesizer = AVSpeechSynthesizer()
        
//        private func readOut(text: String) {
//            let utterance = AVSpeechUtterance(string: text)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//
//            synth.speak(utterance)
//        }

    var body: some View {
        NavigationStack {
            VStack{
                Button {
                    speak()
                } label: {
                    Text("sjsjjjs")
                }

                List {
                    ForEach(schools(), id: \.self) { word in
                        NavigationLink {
                            NewIView()
                               
                        } label: {
                            Text(word)
                        }
                    }
                }
                .navigationTitle(  Text("Select Your School")
                    .font(.custom("Kavoon-Regular", size: 32))
                )
            }
            .onAppear{
               
            }
        }
    }
    
    func schools() -> Array<String>{
        return  ["University Of Westminster", "University of Oxford", "BirbeckUniversity, London", "University of Glasgow"]
    }
    
    func speak(){
        let utterance = AVSpeechUtterance(string: "Hey Ifeoma, How can i help you?")
      //  utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
       
        synthesizer.speak(utterance)
    }
}

struct SelectSchool_Previews: PreviewProvider {
    static var previews: some View {
        SelectSchool()
    }
}
