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
    @Binding internal var partyClickedOn: Party?
    
    private var gridItemLayout: [GridItem] {
        return Array(repeating:GridItem(.flexible()), count: airplane.rowWidth)
    }
    
    var body: some View {
        VStack{
            ForEach(airplane.rows) { row in
                HStack{
                    ForEach(0..<airplane.rowWidth) { seatIndex in
                        if (airplane.rowLayout[seatIndex]) {
                            SeatView(seat: airplane.getSeatFromRow(row: row, seatIndex: seatIndex), partyClickedOn: $partyClickedOn, rows: airplane.rows)
                        } else {
                            Image(systemName: "square").opacity(0)
                        }
                    }
                }

            }
        }
    }
}
