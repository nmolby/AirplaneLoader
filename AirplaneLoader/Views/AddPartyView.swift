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
    internal var inefficientSeatPicker: ([Row], Party) -> [Seat]
    internal var efficientSeatPicker: ([Row], Party) -> [Seat]
    @State private var partyType = PartyType.business
    @State private var peopleNames: [String] = Array(repeating: "", count: 5)
    @State private var wantsBusiness: Bool = true
    @State private var familyNumberOfChildren = 1
    @State private var addingParty = false
    @Binding internal var partyToShow: Party?
    @Binding internal var userType: UserType
    
    var body: some View {
        NavigationView {
            Group {
                if(addingParty) {
                    VStack {
                        Text("Adding new party")
                            .font(.title2)
                            .padding([.bottom], 20)
                        ProgressView()
                            .scaleEffect(x: 3, y: 3)
                    }
                }  else if let partyToShow = partyToShow {
                    ScrollView {
                        ForEach(0..<partyToShow.people.count, id: \.self) { i in
                            PassengerSeatPreviewView(person: partyToShow.people[i], seat: partyToShow.seats[i])
                                .padding([.top, .bottom], 5)
                        }
                        Button("Change Party Seats. \(partyToShow.seatChangesRemaining) Remaining.") {
                            reseatParty()
                        }
                        .disabled(partyToShow.seatChangesRemaining <= 0)
                        .foregroundColor(Color.white)
                        .font(.title2)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(partyToShow.seatChangesRemaining <= 0 ? Color.gray : Color.blue))
                        

                        if(userType != UserType.Passenger) {
                            Button("Add New Party") {
                                self.partyToShow = nil
                            }
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        }
                        Spacer()
                    }
                } else {
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
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
 
        }


    
    }
    
    func reseatParty() {
        addingParty = true
        
        var party = partyToShow!
        
        party.seatChangesRemaining -= 1
        party.previousSeats += party.seats
        for i in 0..<party.seats.count {
            party.seats[i].personInSeat = nil
        }
        party.seats = []
        
        DispatchQueue.global(qos: .background).async {
            var seats: [Seat]
            
            if(party.partyType == PartyType.family) {
                seats = efficientSeatPicker(rows, party)
            } else {
                seats = inefficientSeatPicker(rows, party)
            }
            
            DispatchQueue.main.sync {
                party.seats = seats
                for i in 0..<seats.count {
                    seats[i].personInSeat = party.people[i]
                }
                clearPeople()
                addingParty = false
                partyToShow = party
                party.highlighted = true
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
        
        addingParty = true
        DispatchQueue.global(qos: .background).async {
            var seats: [Seat]

            if(partyType == PartyType.family) {
                seats = efficientSeatPicker(rows, newParty)
            } else {
                seats = inefficientSeatPicker(rows, newParty)
            }
            
            DispatchQueue.main.sync {
                newParty.seats = seats
                for i in 0..<seats.count {
                    seats[i].personInSeat = newParty.people[i]
                }
                clearPeople()
                addingParty = false
                partyToShow = newParty
                newParty.highlighted = true
            }
        }


    }
    
    func clearPeople() {
        self.peopleNames = Array(repeating: "", count: 5)
    }
}
