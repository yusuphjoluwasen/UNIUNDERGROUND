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
            Spacer()
            Text("Add an Event")
                .font(.title)
                .bold()
                .padding(.leading)
            
            TextField("Event Name", text: $eventName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Description", text: $eventDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Location", text: $eventLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Date and Time", text: $eventDateTime)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Event Website", text: $eventWebsite)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SaveButton(action: {
                onSave(eventName, eventDescription, eventLocation, eventDateTime, eventWebsite)
                self.presentationMode.wrappedValue.dismiss()
            })
            
            Spacer()
        }
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

