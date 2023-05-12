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
    @ObservedObject var viewModel:SchoolViewModel = SchoolViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Select Your School")
                    .font(.custom("Kavoon-Regular", size: 32))
                
                Divider()
                
                List {
                    ForEach(viewModel.schools) { school in
                        NavigationLink {
                            LoginView(school: school)

                        } label: {
                            HStack{
                                AsyncImage(url: URL(string: school.logo)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.1)
                                }
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)

                                Text(school.name)

                            }
                        }
                    }
                    
                   
                }
                .listStyle(.inset)
            }
            
            .onAppear{
               // speak()
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
