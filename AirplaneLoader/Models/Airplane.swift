//
//  Airplane.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

class Airplane: ObservableObject {
    @Published var rows: [Row] = []
    
    let rowLayout: [Bool] = [true, true, true, false, false, true, true, true]
    
    var noSeatCount: Int {
        return rowLayout.filter( { !$0 } ).count
    }
    var rowWidth : Int {
        return rowLayout.count
    }
    let rowCount = 20
    
    init() {
        for i in 0..<rowCount {
            rows.append(Row())
            for _ in 0..<(rowWidth - noSeatCount) {
                rows[i].seats.append(Seat())
            }
        }
    }
    
    func getSeatFromRow(row: Row, seatIndex: Int) -> Seat{
        var currentSeatIndex = -1
        for i in 0..<rowWidth {
            if (rowLayout[i]){
                currentSeatIndex += 1
            }
            
            if(i == seatIndex) {
                return row.seats[currentSeatIndex]
            }
        }
        print("THIS IS AN ISSUE")
        return row.seats[0]
    }
    
}

class Row: ObservableObject, Identifiable {
    @Published var seats: [Seat] = []
    
    var id = UUID()
}
