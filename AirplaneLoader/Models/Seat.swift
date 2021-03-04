//
//  Seat.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

class Seat: Identifiable, Hashable, CustomStringConvertible, ObservableObject {
    static func == (lhs: Seat, rhs: Seat) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    
    @Published var personInSeat: Person?
    
    var occupied: Bool {
        return personInSeat != nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var description: String {
        if let person = personInSeat {
            return person.name!
        } else {
            return "Unoccupied"
        }
        
    }
}
