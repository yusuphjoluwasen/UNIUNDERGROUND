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
    @State var firstname = ""
    @State var lastname = ""
    @State var courseofstudy = ""
    var school:School?
    @ObservedObject var viewModel:LoginViewModel = LoginViewModel()
    @EnvironmentObject var vm: AppStateViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) { Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    AsyncImage(url: URL(string: school?.logo ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .frame(width: 80, height: 80)
                  
                        .padding()
                    
                    Group{
                        
                        TextField("", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .placeholder(when: email.isEmpty) {
                                Text("Email").foregroundColor(.gray)
                            }
                        if !isLoginMode{
                            TextField("First Name", text: $firstname)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            TextField("Last Name", text: $lastname)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            TextField("Course Of Study", text: $courseofstudy)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        SecureField("Password", text:$password)
                        
                    }
                    .padding(12)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(Color.whiteColor)
                                .padding(.vertical, 10)
                                .font(.custom("Inter-SemiBold", size: 17))
                            Spacer()
                        }
                        .frame(height: 50)
                        .background(buttonColor)
                        .cornerRadius(10)
                    }
                    .padding(.top)
                    .disabled(!valid)
                    
                    Text(viewModel.loginStatusMessage)
                        .foregroundColor(.red)
                }
//
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)))
            .onChange(of: viewModel.loginStatus) { value in
                if value{
                    vm.signIn()
                }
            }
        }
        
        
    }
    
    private func handleAction() {
        if isLoginMode {
            viewModel.loginUser(email: email, password: password)
        } else {
            viewModel.createNewAccount(email: email, password: password, firstname: firstname, lastname: lastname, course: courseofstudy, school: school!)
        }
    }
    
    private var valid:Bool{
        if isLoginMode{
            if email.isEmpty || password.isEmpty{
               return false
            }else{
                return true
            }
        }else{
            if email.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || courseofstudy.isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    
    private var buttonColor:Color{
        if valid{
            return Color.blackColor
        }else{
            return Color.gray
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(school: School(banner: "https://firebasestorage.googleapis.com/v0/b/uniunderground-83e48.appspot.com/o/uniwestbanner.jpeg?alt=media&token=847f1d92-f055-4d6f-8c6b-f71305606225", id: "UFgPQe8aShmWAWYMZLml", logo: "https://firebasestorage.googleapis.com/v0/b/uniunderground-83e48.appspot.com/o/uniwestminsterlogo.png?alt=media&token=58a1353d-87c0-4395-bd00-8af7199ad0f1", name: "University of Westminster"))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}



