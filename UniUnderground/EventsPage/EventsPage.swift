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
        Event(name: "Event 3", description: "Description 3", location: "Location 3", dateTime: "DateTime 3", website: "Website 3"),
        Event(name: "Event 4", description: "Description 4", location: "Location 4", dateTime: "DateTime 4", website: "Website 4"),
        Event(name: "Event 5", description: "Description 5", location: "Location 5", dateTime: "DateTime 5", website: "Website 5")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Events 🧜🏽‍♀️")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                
                Rectangle()
                    .frame(width: 300, height: 1, alignment: .center)
                    .foregroundColor(.gray)

                EventSearchBar(text: $searchText)
                    .padding(.horizontal)

                List(events.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { event in
                    VStack(alignment: .leading) {
                        Text(event.name)
                            .font(.headline)
                        Text(event.description)
                            .font(.subheadline)
                        Text(event.location)
                            .font(.subheadline)
                        Text(event.dateTime)
                            .font(.subheadline)
                        Text(event.website)
                            .font(.subheadline)
                    }
                }

                Spacer()

                NavigationLink(destination: AddEventView(onSave: { name, description, location, dateTime, website in
                    let newEvent = Event(name: name, description: description, location: location, dateTime: dateTime, website: website)
                    events.append(newEvent)
                })) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.blue)
                        .padding(.leading)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
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
