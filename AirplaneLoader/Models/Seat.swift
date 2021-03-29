//
//  Seat.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

enum SeatType {
    case Window
    case Middle
    case Aisle
}

class Seat: Identifiable, Hashable, CustomStringConvertible, ObservableObject {
    var seatType: SeatType
    var rowNumber: Int
    var seatLetter: String
    var id = UUID()
    var business: Bool
    @Published var personInSeat: Person?
    
    var description: String {
        if let person = personInSeat {
            return person.name!
        } else {
            return "Unoccupied"
        }
    }
    
    var occupied: Bool {
        return personInSeat != nil
    }
    
    init(seatType: SeatType, rowNumber: Int, seatLetter: String, business: Bool = false, personInSeat: Person? = nil) {
        self.business = business
        self.personInSeat = personInSeat
        self.seatType = seatType
        self.rowNumber = rowNumber
        self.seatLetter = seatLetter
    }
    
    static func == (lhs: Seat, rhs: Seat) -> Bool {
        return lhs.id == rhs.id
    }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
