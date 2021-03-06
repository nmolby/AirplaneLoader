//
//  AddPartyView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation
import SwiftUI

struct AddPartyView: View {
    @Binding internal var rows: [Row]
    internal var seatPicker: ([Row], Party) -> [Seat]
    @State private var partyType = PartyType.business
    @State private var peopleNames: [String] = ["", "", "", "", ""]
    @State private var wantsBusiness: Bool = true
    @State private var familyNumberOfChildren = 1
    
    var body: some View {
            Form {
                Picker("Party Type", selection: $partyType) {
                    Text("Business").tag(PartyType.business)
                    Text("Family").tag(PartyType.family)
                    Text("Tourist").tag(PartyType.tourist)
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 130)
                switch(partyType) {
                case PartyType.business:
                    TextField("Traveler Name", text: $peopleNames[0])
                    Toggle("Business Seats Preferred?", isOn: $wantsBusiness)
                    Button("Add party") {
                        createParty(partyType: PartyType.business)
                    }.disabled(peopleNames[0] == "")
                    
                case PartyType.tourist:
                    TextField("Traveler 1 Name", text: $peopleNames[0])
                    TextField("Traveler 2 Name", text: $peopleNames[1])
                    Button("Add party") {
                        createParty(partyType: PartyType.tourist)
                    }.disabled(peopleNames[0] == "" || peopleNames[1] == "")
                case PartyType.family:
                    TextField("Traveler 1 Name", text: $peopleNames[0])
                    TextField("Traveler 2 Name", text: $peopleNames[1])
                    TextField("Traveler 3 Name", text: $peopleNames[2])
                    if(familyNumberOfChildren >= 2) {
                        TextField("Traveler 4 Name", text: $peopleNames[3])
                    }
                    if(familyNumberOfChildren >= 3) {
                        TextField("Traveler 5 Name", text: $peopleNames[4])
                    }
                    HStack {
                        Button("+") { familyNumberOfChildren += 1}.disabled(familyNumberOfChildren >= 3)
                            .buttonStyle(BorderlessButtonStyle())
                        Button("-") {familyNumberOfChildren -= 1}.disabled(familyNumberOfChildren <= 1)
                            .buttonStyle(BorderlessButtonStyle())
                    }
                    Button("Add party") {
                        createParty(partyType: PartyType.family)
                    }.disabled(peopleNames[0] == "" || peopleNames[1] == "")                }
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
            for i in 0..<(familyNumberOfChildren + 2) {
                let newPerson = Person(name: peopleNames[i], id: UUID(), party: newParty)
                newParty.people.append(newPerson)
            }
        case PartyType.tourist:
            newParty = TouristParty()
            let newPerson1 = Person(name: peopleNames[0], id: UUID(), party: newParty)
            let newPerson2 = Person(name: peopleNames[1], id: UUID(), party: newParty)
            newParty.people.append(newPerson1)
            newParty.people.append(newPerson2)

        }
        seatPicker(rows, newParty)
    }
}
