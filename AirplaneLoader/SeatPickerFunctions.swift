//
//  SeatPickerFunction.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/23/21.
//

import Foundation

class SeatPickerFunctions {
    static func basicSeatPicker(rows: [Row], party: Party) -> [Seat] {
        var seatsToAdd : [Seat] = []
        for _ in party.people {
            for row in rows {
                var foundSeat = false
                for seat in row.seats {
                    if(!seat.occupied && !seatsToAdd.contains(seat) && !party.previousSeats.contains(seat)) {
                        seatsToAdd.append(seat)
                        foundSeat = true
                        break
                    }
                }
                if(foundSeat) {
                    break
                }
            }
        }
        return seatsToAdd
    }
    
    static func familySeatPicker(rows: [Row], party: Party) -> [Seat] {
        var maxSatisfaction = -100
        var bestSeats: [Seat] = []
        
        for row in rows {
            for seat in row.seats {
                if(!seat.occupied) {
                    let seatResult = familySeatPickerHelper(currentSeats: [seat], mostRecentAddedSeat: seat, rows: rows, party: party)
                    if seatResult.satisfaction  > maxSatisfaction {
                        maxSatisfaction = seatResult.satisfaction
                        bestSeats = seatResult.seats
                    }
                }
            }
        }
        
        if bestSeats.isEmpty {
            bestSeats = basicSeatPicker(rows: rows, party: party)
        }
        return bestSeats
    }
    
    static func familySeatPickerHelper(currentSeats: [Seat], mostRecentAddedSeat: Seat, rows: [Row], party: Party) -> (seats: [Seat], satisfaction: Int) {
        var maxSatisfaction = -100
        var bestSeats: [Seat] = []
        for direction in Direction.allCases {
            let nextSeat = getNextSeat(seat: mostRecentAddedSeat, rows: rows, direction: direction)
            if let nextSeat = nextSeat, !currentSeats.contains(nextSeat), !party.previousSeats.contains(nextSeat) {
                var newSeats = currentSeats
                newSeats.append(nextSeat)
                if newSeats.count == party.people.count {
                    var satisfaction = 10
                    satisfaction += nextSeat.seatType == SeatType.Aisle ? 5 : 0
                    return (newSeats, satisfaction)
                } else {
                    let seatResult = familySeatPickerHelper(currentSeats: newSeats, mostRecentAddedSeat: nextSeat, rows: rows, party: party)
                    var newSatisfaction = seatResult.satisfaction
                    if(nextSeat.seatType == SeatType.Aisle) {
                        newSatisfaction += 5
                    }
                    if newSatisfaction  > maxSatisfaction {
                        maxSatisfaction = newSatisfaction
                        bestSeats = seatResult.seats
                    }
                }
            }
        }
        return (bestSeats, maxSatisfaction)
    }
    
    static func recursiveSeatPicker(rows: [Row], party:  Party) -> [Seat] {
        return recursiveSeatPickerHelper(rows: rows, party: party, indexOfPerson: 0, currentSeats: []).seats
    }
    
    static func recursiveSeatPickerHelper(rows: [Row], party:  Party, indexOfPerson: Int, currentSeats: [Seat]) -> (seats: [Seat], satisfaction: Int) {
        if(indexOfPerson == party.people.count) {
            return (currentSeats, party.getSatisfaction(seats: currentSeats, rows: rows))
        }
        
        var bestSeats: [Seat] = []
        var bestSatisfaction: Int = -100000
        
        for row in rows {
            for seat in row.seats {
                if(!currentSeats.contains(seat) && !seat.occupied && !party.previousSeats.contains(seat)) {
                    var seatsToCheck = currentSeats
                    seatsToCheck.append(seat)
                    
                    let returnValue =  recursiveSeatPickerHelper(rows: rows, party: party, indexOfPerson: indexOfPerson + 1, currentSeats: seatsToCheck)
                    if(returnValue.satisfaction > bestSatisfaction) {
                        bestSeats = returnValue.seats
                        bestSatisfaction = returnValue.satisfaction
                    }
                }
               
            }
        }
        
        var currentBestSeats = currentSeats
        currentBestSeats += bestSeats
        return (bestSeats, bestSatisfaction)
    }
    
    static func getNextSeat(seat: Seat, rows: [Row], direction: Direction) -> Seat? {
        switch(direction) {
        case .North:
            let newSeatRow = seat.rowNumber - 1
            if newSeatRow < 0 {
                return nil
            }
            let newSeat = rows[newSeatRow].seats[seat.seatNumber]
            return newSeat.occupied ? nil : newSeat
        case .East:
            let newSeatNumber = seat.seatNumber + 1
            if newSeatNumber >= rows[0].seats.count {
                return nil
            }
            let newSeat = rows[seat.rowNumber].seats[newSeatNumber]
            return newSeat.occupied ? nil : newSeat
        case .South:
            let newSeatRow = seat.rowNumber + 1
            if newSeatRow >= rows.count {
                return nil
            }
            let newSeat = rows[newSeatRow].seats[seat.seatNumber]
            return newSeat.occupied ? nil : newSeat
        case .West:
            let newSeatNumber = seat.seatNumber - 1
            if newSeatNumber < 0 {
                return nil
            }
            let newSeat = rows[seat.rowNumber].seats[newSeatNumber]
            return newSeat.occupied ? nil : newSeat
        }
    }

}
