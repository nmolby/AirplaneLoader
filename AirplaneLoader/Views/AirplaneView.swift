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
            ForEach(airplane.rows) { row in
                HStack{
                    ForEach(0..<airplane.rowWidth) { seatIndex in
                        if (airplane.rowLayout[seatIndex]) {
                            SeatView(seat: airplane.getSeatFromRow(row: row, seatIndex: seatIndex))

                        } else {
                            Image(systemName: "square").opacity(0)
                        }
                    }
                }

            }
        }
    }
}
