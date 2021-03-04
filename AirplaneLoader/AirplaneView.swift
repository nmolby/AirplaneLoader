//
//  AirplaneView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation
import SwiftUI

struct AirplaneView: View {
    @ObservedObject internal var airplane: Airplane
    
    var body: some View {
        VStack{
            ForEach(airplane.seats, id: \.self) { row in
                HStack{
                    ForEach(row, id: \.self) { seat in
                        if(seat.occupied) {
                            switch(seat.personInSeat!.party.partyType) {
                            case PartyType.business:
                                Image(systemName: "square.fill").foregroundColor(.blue)
                            case PartyType.tourist:
                                Image(systemName: "square.fill").foregroundColor(.green)
                            case PartyType.family:
                                Image(systemName: "square.fill").foregroundColor(.yellow)
                            }
                        } else {
                            Image(systemName: "square")
                        }
                    }
//                    ForEach(0..<airplane.rowWidth) { seatIndex in
//                        if (airplane.rowLayout[seatIndex]) {
//                            if(airplane.getSeatFromRow(row: row, seatIndex: seatIndex).occupied) {
//                                Text("occupation")
//                                switch(airplane.getSeatFromRow(row: row, seatIndex: seatIndex).personInSeat!.party.partyType) {
//                                case PartyType.business:
//                                    Image(systemName: "square.fill").foregroundColor(.blue)
//                                case PartyType.tourist:
//                                    Image(systemName: "square.fill").foregroundColor(.green)
//                                case PartyType.family:
//                                    Image(systemName: "square.fill").foregroundColor(.yellow)
//                                }
//                            } else{
//                                Image(systemName: "square")
//                            }
//
//                        } else {
//                            Image(systemName: "square").opacity(0)
//                        }
//                    }
                }

            }
        }
    }
}
