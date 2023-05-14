//
//  AddEventView.swift
//  UniUnderground
//
//  Created by Betty Demissie on 12/05/2023.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    let onSave: (String, String, String, String, String) -> Void
    
    @State private var eventName = ""
    @State private var eventDescription = ""
    @State private var eventLocation = ""
    @State private var eventDateTime = ""
    @State private var eventWebsite = ""
    
    var body: some View {
        VStack {
            
            Text("Add a Social Event")
                .font(.custom("Inter-Bold", size: 32))
                .padding(.trailing, 50)
        
            Rectangle()
                .fill(Color.secondary)
                .opacity(0.4)
                .frame(width: 360, height: 1)
                .padding(.bottom)
        

            TextField("Title", text: $eventName)
                .font(.custom("InriaSerif-Regular", size: 16))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $eventDescription)
                .font(.custom("InriaSerif-Regular", size: 16))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Location", text: $eventLocation)
                .font(.custom("InriaSerif-Regular", size: 16))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Date", text: $eventDateTime)
                .font(.custom("InriaSerif-Regular", size: 16))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Link", text: $eventWebsite)
                .font(.custom("InriaSerif-Regular", size: 16))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ZStack {
                            Rectangle()
                                .fill(Color.blackColor)
                                .frame(width: 350, height: 40)
                                .cornerRadius(8)
                            Button(action: {
                                onSave(eventName, eventDescription, eventLocation, eventDateTime, eventWebsite)
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("CREATE")
                                    .font(.headline)
                                    .foregroundColor(.whiteColor)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        
            
            Spacer()
        }.padding(.horizontal)
    }
}

struct SaveButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Save")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(8)
        .padding()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(onSave: { name, description, location, time, link in
            // Do something with the values
        })

    }
}

