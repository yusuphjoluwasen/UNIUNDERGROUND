//
//  AddEventView.swift
//  UniUnderground
//
//  Created by Betty Demissie on 12/05/2023.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    // let onSave: (String, String, String, String, String) -> Void
    @ObservedObject var viewModel:EventsViewModel = EventsViewModel()
    
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
                .frame(width: 344, height: 41, alignment: .leading)
            
            Rectangle()
                .fill(Color.secondary)
                .opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .padding(.bottom)
            
            TextField("", text: $eventName)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .font(.custom("InriaSerif-Regular", size: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
                .placeholder(when: eventName.isEmpty) {
                    Text(" Title").foregroundColor(.gray)
                }
            
            TextField("", text: $eventDescription)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .font(.custom("InriaSerif-Regular", size: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
                .placeholder(when: eventDescription.isEmpty) {
                    Text(" Description").foregroundColor(.gray)
                }
            
            
            TextField("", text: $eventLocation)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .font(.custom("InriaSerif-Regular", size: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
                .placeholder(when: eventLocation.isEmpty) {
                    Text(" Location").foregroundColor(.gray)
                }
            
            TextField("", text: $eventDateTime)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .font(.custom("InriaSerif-Regular", size: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
                .placeholder(when: eventDateTime.isEmpty) {
                    Text(" Date").foregroundColor(.gray)
                }
            
            TextField("", text: $eventWebsite)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .keyboardType(.URL)
                .font(.custom("InriaSerif-Regular", size: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
                .placeholder(when: eventWebsite.isEmpty) {
                    Text(" Link").foregroundColor(.gray)
                }
            
            ZStack {
                Button(action: {
                    addEvent()
                }) {
                    Text("CREATE")
                        .font(.custom("Inter-SemiBold", size: 17))
                        .foregroundColor(Color.whiteColor)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 50)
            .background(buttonColor)
            .cornerRadius(10)
            .disabled(!valid)
            
            Spacer()
        }
        .onChange(of: viewModel.createNewEventStatus) { value in
            if value{
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(.horizontal)
    }
    
    var valid: Bool{
        if eventName == "" || eventDescription == "" || eventLocation == "" || eventDateTime == "" {
            return false
        }else{
            return true
        }
    }
    
    private var buttonColor:Color{
        if valid{
            return Color.blackColor
        }else{
            return Color.gray
        }
    }
    
    func addEvent(){
        viewModel.createSocialEvent(event: CreateSocialEvent(name: eventName, description: eventDescription, location: eventLocation, dateTime: eventDateTime, url: eventWebsite))
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
        AddEventView()

    }
}

