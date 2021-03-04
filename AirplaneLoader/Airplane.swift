//
//  Airplane.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

class Airplane: ObservableObject {
    @Published var seats: [[Seat]] = [[]]
    
    let rowLayout: [Bool] = [true, true, true, true, true, true]
    
    var noSeatCount: Int {
        return rowLayout.filter( { !$0 } ).count
    }
    var rowWidth : Int {
        return rowLayout.count
    }
    let rowCount = 20
    
    init() {
        for i in 0..<rowCount {
            seats.append([])
            for _ in 0..<(rowWidth - noSeatCount) {
                seats[i].append(Seat())
            }
        }
    }
    
    func getSeatFromRow(row: [Seat], seatIndex: Int) -> Seat{
        var currentSeatIndex = -1
        for i in 0..<rowWidth {
            if (rowLayout[i]){
                currentSeatIndex += 1
            }
            
            if(i == seatIndex) {
                return row[currentSeatIndex]
            }
        }
        print("THIS IS AN ISSUE")
        return row[0]
    }
    
}
