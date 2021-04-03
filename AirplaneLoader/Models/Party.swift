//
//  Party.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

enum PartyType: String, CaseIterable, Identifiable {
    case business
    case tourist
    case family
    
    var id: String { self.rawValue }
}


protocol Party {
    var id: UUID {get}
    var people: [Person] { get set }
    var highlighted: Bool { get set }
    var partyType: PartyType {get}
    var peopleCountRange: (Int, Int) { get }
    var seats: [Seat] { get set }
    var previousSeats: [Seat] { get set}
    var seatChangesRemaining: Int { get set }
    
    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int
}

class BusinessParty: Party {
    var previousSeats: [Seat] = []
    var seatChangesRemaining = 2
    var highlighted: Bool = false
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.business
    var wantsBusinessSeats: Bool
    var peopleCountRange = (1, 1)
    
    init(wantsBusinessSeats: Bool) {
        self.wantsBusinessSeats = wantsBusinessSeats
    }
    
    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        print(seats)
        let seat = seats[0]
        if(seat.business && wantsBusinessSeats) {
            return 5
        } else if (!seat.business && wantsBusinessSeats) {
            return -5
        }
        return 0
    }
    
}

class TouristParty: Party, ObservableObject {
    var previousSeats: [Seat] = []
    var seatChangesRemaining = 2
    var highlighted: Bool = false
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.tourist
    var peopleCountRange = (2, 2)

    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        //if one of the passengers is in a window seat
        if(seats[0].seatType == SeatType.Window || seats[1].seatType == SeatType.Window) {
            let seatsLocations = getSeatsLocations(seats: seats, rows: rows)
            //if they are in the same row
            if(seatsLocations[0].rowNum == seatsLocations[1].rowNum) {
                //if they are next to each other in the same row
                if(abs(seatsLocations[0].seatNum - seatsLocations[1].seatNum) == 1){
                    return 5
                }
            }
        }
        if(seats[0].business && seats[1].business) {
            return 0
        }
        return -5
    }
    
}

class FamilyParty: Party, ObservableObject {
    var previousSeats: [Seat] = []
    var seatChangesRemaining = 2
    var highlighted: Bool = false
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.family
    var peopleCountRange = (3, 5)

    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        var satisfaction = 0
        if(allNeighboring(seatLocations: getSeatsLocations(seats: seats, rows: rows))) {
            satisfaction = 10
        } else {
            satisfaction = -10
        }
        for seat in seats {
            if (seat.seatType == SeatType.Aisle) {
                satisfaction += 5
            }
        }
        return satisfaction
    }
    
    func allNeighboring(seatLocations: [(rowNum: Int, seatNum: Int)]) -> Bool {
        for seatLocation1 in seatLocations {
            var touchingAnotherSeat = false
            for seatLocation2 in seatLocations {
                if((abs(seatLocation1.rowNum - seatLocation2.rowNum) == 1 && seatLocation1.seatNum == seatLocation2.seatNum) ||
                    (abs(seatLocation1.seatNum - seatLocation2.seatNum) == 1 && seatLocation1.rowNum == seatLocation2.rowNum)) {
                    touchingAnotherSeat = true
                }
            }
            if (!touchingAnotherSeat) {
                return false
            }
        }
        return true
    }
    
}

