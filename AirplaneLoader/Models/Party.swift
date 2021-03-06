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
    var people: [Person] {get set}
    var partyType: PartyType {get}
    
    func getSatisfaction(seat: Seat, rows: [Row]) -> Int

}

struct BusinessParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.business
    var wantsBusinessSeats: Bool
    
    func getSatisfaction(seat: Seat, rows: [Row]) -> Int {
        if(seat.business && wantsBusinessSeats) {
            return 5
        } else if (!seat.business && wantsBusinessSeats) {
            return -5
        }
        return 0
    }
    
}

struct TouristParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.tourist
    
    func getSatisfaction(seat: Seat, rows: [Row]) -> Int {
        return 0
    }
    
}

struct FamilyParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.family
    
    func getSatisfaction(seat: Seat, rows: [Row]) -> Int {
        return 0
    }
    
}

