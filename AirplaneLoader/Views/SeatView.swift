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
    var body: some View {
        if(seat.occupied) {
            switch(seat.personInSeat!.party.partyType) {
            case PartyType.business:
                SeatImageView(occupied: true).foregroundColor(.blue)
            case PartyType.tourist:
                SeatImageView(occupied: true).foregroundColor(.green)
            case PartyType.family:
                SeatImageView(occupied: true).foregroundColor(.yellow)
            }
        } else {
            SeatImageView(occupied: false)
        }
    }
}
