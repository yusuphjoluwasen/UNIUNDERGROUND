//
//  LoginView.swift
//  UniUnderground
//
//  Created by Guru King on 10/05/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) { Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button{
                            
                        } label: {Image(systemName:"person.fill")
                                .font(.system(size:64))
                                .padding()
                        }
                        
                    }
                    Group{
                        
                         TextField("Email", text: $email)
                             .keyboardType(.emailAddress)
                             .autocapitalization(.none)
                             
                     SecureField("Password", text:$password)
                        
                    }
                    .padding(12)
                    .background(Color.white)
                        
                        
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text(isLoginMode ? "Log In" : "Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 14, weight: .semibold))
                                Spacer()
                            }.background(Color.blue)
                            
                        }
                        
                    }
                
                    .padding()
                    
                }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)))
        
        }
        
    }
    private func handleAction() {
        if isLoginMode {
           print("Should log into Firebase with existing credentials")
        }else{
            print("Register a new accountinside of Firebase Auth and then store image in Storage somehow...")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
