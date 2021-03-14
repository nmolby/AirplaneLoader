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
    var partyType: PartyType {get}
    var peopleCountRange: (Int, Int) { get }
    var seats: [Seat] { get set }
    
    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int

}

struct BusinessParty: Party {
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.business
    var wantsBusinessSeats: Bool
    var peopleCountRange = (1, 1)
    
    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        let seat = seats[0]
        if(seat.business && wantsBusinessSeats) {
            return 5
        } else if (!seat.business && wantsBusinessSeats) {
            return -5
        }
        return 0
    }
    
}

struct TouristParty: Party {
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.tourist
    var peopleCountRange = (2, 2)

    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        return 0
    }
    
}

struct FamilyParty: Party {
    var seats: [Seat] = []
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.family
    var peopleCountRange = (3, 5)

    func getSatisfaction(seats: [Seat], rows: [Row]) -> Int {
        return 0
    }
    
}

