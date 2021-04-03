//
//  PassengerSeatPreviewView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/2/21.
//

import SwiftUI

struct PassengerSeatPreviewView: View {
    let person: Person
    let seat: Seat
    var body: some View {
        HStack {
            Text("\(person.name!) is in seat \(seat.description)")
                .font(.title2)
                .padding()
            Spacer()
            NavigationLink(destination: PassengerTicketView(person: person, seat: seat)) {
                Image(systemName: "barcode.viewfinder")
                    .scaleEffect(x: 2.5, y: 2.5)
                    .padding([.trailing], 15)
            }
            
        }
        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))

    }
}
