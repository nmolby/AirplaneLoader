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
    @Binding internal var partyToShow: Party?
    @Binding internal var userType: UserType
    internal var letteringSize: CGFloat = 13
    
    private var gridItemLayout: [GridItem] {
        return Array(repeating:GridItem(.flexible()), count: airplane.rowWidth)
    }
    
    var body: some View {

        VStack(spacing: 2) {
            HStack{
                Text("")
                    .font(.system(size: letteringSize))
                    .frame(width: 20)

                ForEach(0..<airplane.rowWidth) { seatIndex in
                    if (airplane.rowLayout[seatIndex]) {
                        Text(airplane.getSeatLetterFromIndex(seatIndex: seatIndex))
                            .font(.system(size: letteringSize))
                            .frame(width: 20)
                    } else {
                        Image(systemName: "square").opacity(0)
                    }
                }
            }
            ForEach(airplane.rows) { row in
                HStack{
                    Text(String(row.rowNum))
                        .font(.system(size: letteringSize))
                        .frame(width: 20)

                    ForEach(0..<airplane.rowWidth) { seatIndex in
                        if (airplane.rowLayout[seatIndex]) {
                            SeatView(seat: airplane.getSeatFromRow(row: row, seatIndex: seatIndex), partyToShow: $partyToShow, userType: $userType, rows: airplane.rows)
                        } else {
                            Image(systemName: "square").opacity(0)
                        }
                    }
                }

            }
        }
    }
}
