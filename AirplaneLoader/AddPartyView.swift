//
//  AddPartyView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation
import SwiftUI

struct AddPartyView: View {
    @Binding internal var seats: [[Seat]]
    internal var seatPicker: ([[Seat]], Party) -> [Seat]
    @State private var partyType = PartyType.business
    @State private var peopleNames: [String] = ["", "", "", "", ""]
    @State private var wantsBusiness: Bool = true
    
    var body: some View {
        VStack{
            Picker("Party Type", selection: $partyType) {
                Text("Business").tag(PartyType.business)
                Text("Family").tag(PartyType.family)
                Text("Tourist").tag(PartyType.tourist)
            }
            switch(partyType) {
            case PartyType.business:
                TextField("Name", text: $peopleNames[0])
                Toggle("Business Seats Preferred?", isOn: $wantsBusiness)
                Button("Add party") {
                    print(seats[0])
                    createParty(partyType: PartyType.business)
                }.disabled(peopleNames[0] == "")
            case PartyType.family:
                Text("Family")
            case PartyType.tourist:
                Text("Tourist")
            }
            
        }
    }
    func createParty (partyType: PartyType) {
        var newParty: Party
        
        switch(partyType) {
        case PartyType.business:
            newParty = BusinessParty(wantsBusinessSeats: wantsBusiness)
            let newPerson = Person(name: peopleNames[0], id: UUID(), party: newParty)
            newParty.people.append(newPerson)
        case PartyType.family:
            newParty = FamilyParty()
        case PartyType.tourist:
            newParty = TouristParty()
        }
        seatPicker(seats, newParty)
        print("added person")
    }
}
