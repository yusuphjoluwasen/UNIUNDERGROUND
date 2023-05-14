//
//  EventsPage.swift
//  UniUnderground
//
//  Created by Betty Demissie on 12/05/2023.
//

import SwiftUI

struct EventsPage: View {
    @State private var searchText = ""
    @State private var events = [
        Event(name: "Event 1", description: "Description 1", location: "Location 1", dateTime: "DateTime 1", website: "Website 1"),
        Event(name: "Event 2", description: "Description 2", location: "Location 2", dateTime: "DateTime 2", website: "Website 2"),
        Event(name: "Event 3", description: "Description 3", location: "Location 3", dateTime: "DateTime 3", website: "Website 3")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Socials 🧜🏽‍♀️")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                
                EventSearchBar(text: $searchText)
                
                Rectangle()
                    .fill(Color.secondary)
                    .opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: 1)

                List(events.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { event in
                    VStack(alignment: .leading) {
                        Text(event.name)
                            .font(.headline)
                        Text(event.description)
                            .font(.subheadline)
                        HStack{
                            Text("📆\(event.location)")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text(event.dateTime)
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .padding(.trailing)
                
                Spacer()
                HStack{
                    Spacer()
                    NavigationLink(destination: AddEventView(onSave: { name, description, location, dateTime, website in
                        let newEvent = Event(name: name, description: description, location: location, dateTime: dateTime, website: website)
                        events.append(newEvent)
                    })) {
                        ZStack{
                            Circle()
                                .fill(Color.blackColor)
                                .frame(width: 70, height: 70)
                            Image(systemName: "plus")
                                .font(.system(size: 18))
                                .foregroundColor(.whiteColor)
                                .padding(.leading, 1)
                        }.padding(.horizontal)
                            

                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}


extension String: Identifiable {
    public var id: String { self }
}

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage()
    }
}
