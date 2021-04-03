//
//  SeatView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/4/21.
//

import Foundation
import SwiftUI

struct SeatView: View {
    @ObservedObject internal var seat: Seat
    @Binding internal var partyClickedOn: Party?
    internal var rows: [Row]
    
    private var occupancyColor: Color {
        if(!seat.occupied) { return Color.white }
        switch(seat.personInSeat!.party.partyType) {
        case PartyType.business:
            return Color.pink
        case PartyType.tourist:
            return Color.purple
        case PartyType.family:
            return Color(red: 115 / 255, green: 220 / 255, blue: 255 / 255)
        }
    }
    
    private var borderColor: Color {
        return seat.business ? Color.blue : Color.black
    }
    
    private var satisfactionColor: Color {
        if let personInSeat = seat.personInSeat {
            if(personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < -5) {
                return Color.red
            } else if (personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 0) {
                return Color.yellow
            } else if(personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 5) {
                return Color.white
            } else if (personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 10) {
                return Color(red: 0.671875, green: 0.69921875, blue: 0.203125)
            } else {
                return Color.green
            }
        }
        else {
            return Color.white
        }
    }
    
    var body: some View {
        Button(action: {
            if (seat.occupied) {
                partyClickedOn = seat.personInSeat!.party
            }
        }, label: {
            ZStack{
                Image(systemName: "square.fill")
                    .foregroundColor(satisfactionColor)
                Image(systemName: "circle.fill.square.fill")
                    .foregroundColor(occupancyColor)
                Image(systemName: "square")
                    .foregroundColor(borderColor)
            }
            
        })

    }
}
