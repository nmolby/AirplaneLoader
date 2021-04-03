//
//  PassengerTicketView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/2/21.
//

import SwiftUI

struct PassengerTicketView: View {
    let person: Person
    let seat: Seat
    var body: some View {
        VStack {
            Text(person.name!)
            Text(seat.description)
        }
    }
}
