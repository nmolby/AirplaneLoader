//
//  Airplane.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

class Airplane: ObservableObject {
    @Published var rows: [Row] = []
    
    let seatingAlphabet = ["A", "B", "C", "D", "E", "F", "G", "H"]
    let rowLayout: [Bool] = [true, true, true, false, false, true, true, true]
    
    let businessRowCount = 2
    
    var noSeatCount: Int {
        return rowLayout.filter( { !$0 } ).count
    }
    var rowWidth : Int {
        return rowLayout.count
    }
    let rowCount = 20
    
    init() {
        for i in 0..<rowCount {
            rows.append(Row(rowNum: i + 1))
            for j in 0..<rowWidth {
                if(rowLayout[j]) {
                    var seatType: SeatType
                    
                    //if the seat is at the far left or far right of the plane, it is a window seat
                    if(j == 0 || j == rowWidth - 1) {
                        seatType = SeatType.Window
                    //if the seat has an empty space to its left or right, it is an aisle seat
                    } else if (!rowLayout[j - 1] || !rowLayout[j + 1]) {
                        seatType = SeatType.Aisle
                    } else{
                        seatType = SeatType.Middle
                    }
                    
                    if(i < businessRowCount) {
                        rows[i].seats.append(Seat(seatType: seatType, rowNumber: i + 1, seatLetter: seatingAlphabet[getActualSeatIndexFromRowLayout(seatIndex: j)], business: true))
                    } else {
                        rows[i].seats.append(Seat(seatType: seatType, rowNumber: i + 1, seatLetter: seatingAlphabet[getActualSeatIndexFromRowLayout(seatIndex: j)]))
                    }
                }

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
    
    func getSeatLetterFromIndex(seatIndex: Int) -> String {
        var currentSeatIndex = -1
        for i in 0..<rowWidth {
            if (rowLayout[i]){
                currentSeatIndex += 1
            }
            
            if(i == seatIndex) {
                return seatingAlphabet[currentSeatIndex]
            }
        }
        print("THIS IS AN ISSUE")
        return ""
    }
    
    func getActualSeatIndexFromRowLayout(seatIndex: Int) -> Int {
        var actualSeatIndex = 0
        for i in 0..<rowLayout.count {
            if(i == seatIndex) {
                return actualSeatIndex
            }
            if(rowLayout[i]) {
                actualSeatIndex += 1
            }
        }
        return -1
    }
    
    func getOccupiedSeats() -> [Seat] {
        var seats: [Seat] = []
        for row in rows {
            for seat in row.seats {
                if(seat.occupied) {
                    seats.append(seat)

                }
            }
        }
        return seats
    }
    
    func getParties() -> [Party] {
        var parties: [Party] = []
        for row in rows {
            for seat in row.seats {
                if(seat.occupied && !parties.map({$0.id}).contains(seat.personInSeat!.party.id) ) {
                    parties.append(seat.personInSeat!.party)

                }
            }
        }
        return parties
    }
    
    func getTotalSatisfaction() -> Int {
        return getParties().map({$0.getSatisfaction(seats: $0.seats, rows: rows)}).reduce(0, {x, y in x + y})
    }
    
}

class Row: ObservableObject, Identifiable {
    @Published var seats: [Seat] = []
    internal var rowNum: Int
    
    var id = UUID()
    
    init(rowNum: Int) {
        self.rowNum = rowNum
    }
    
}

func getSeatsLocations(seats: [Seat], rows: [Row]) -> [(rowNum: Int, seatNum: Int)]{
    var seatLocations: [(Int, Int)] = []
    for seat in seats {
        seatLocations.append(getSeatLocation(seat: seat, rows: rows))
    }
    return seatLocations
}

func getSeatLocation(seat: Seat, rows: [Row]) -> (rowNum: Int, seatNum: Int){
    for i in 0..<rows.count {
        for j in 0..<rows[i].seats.count {
            if(rows[i].seats[j] == seat) {
                return (i, j)
            }
        }
    }
    return (-1, -1)
}
