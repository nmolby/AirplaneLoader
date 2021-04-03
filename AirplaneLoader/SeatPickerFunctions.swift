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

}
