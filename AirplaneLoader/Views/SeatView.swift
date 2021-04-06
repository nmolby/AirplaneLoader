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
    @Binding internal var partyToShow: Party?
    @Binding internal var userType: UserType

    internal var rows: [Row]
    
    private var occupancyColor: Color {
        if(!seat.occupied) { return Color.EMPTY_SEAT_COLOR }
        
        if(userType == UserType.Passenger) {
            if(seat.occupied) {
                if(seat.personInSeat!.party === partyToShow) {
                    return Color.PARTY_SEAT_COLOR
                } else {
                    return Color.OCCUPIED_SEAT_COLOR
                }
            }
        }
        
        switch(seat.personInSeat!.party.partyType) {
        case PartyType.business:
            return Color.BUSINESS_SEAT_COLOR
        case PartyType.tourist:
            return Color.TOURIST_SEAT_COLOR
        case PartyType.family:
            return Color.FAMILY_SEAT_COLOR
        }
    }
    
    private var borderColor: Color {
        return seat.business ? Color.BUSINESS_BORDER_COLOR : Color.DEFAULT_BORDER_COLOR
    }
    
    private var satisfactionColor: Color {
        if(userType == UserType.Passenger) {
            if(seat.occupied) {
                if(seat.personInSeat!.party === partyToShow) {
                    return Color.PARTY_SEAT_COLOR
                } else {
                    return Color.OCCUPIED_SEAT_COLOR
                }
            } else {
                return Color.EMPTY_SEAT_COLOR
            }
        }
        if let personInSeat = seat.personInSeat {
            if(personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < -5) {
                return Color.VERY_LOW_SATISFACTION_COLOR
            } else if (personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 0) {
                return Color.LOW_SATISFACTION_COLOR
            } else if(personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 5) {
                return Color.AVERAGE_SATISFACTION_COLOR
            } else if (personInSeat.party.getSatisfaction(seats: personInSeat.party.seats, rows: rows) < 10) {
                return Color.HIGH_SATISFACTION_COLOR
            } else {
                return Color.VERY_HIGH_SATISFACTION_COLOR
            }
        }
        else {
            return Color.EMPTY_SEAT_COLOR
        }
    }
    
    var body: some View {
        Button(action: {
            if (seat.occupied && userType != UserType.Passenger) {
                partyToShow = seat.personInSeat!.party
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
