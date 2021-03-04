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
}

struct BusinessParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.business
    var wantsBusinessSeats: Bool
}

struct TouristParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.tourist
}

struct FamilyParty: Party {
    let id = UUID()
    var people: [Person] = []
    let partyType = PartyType.family
}

