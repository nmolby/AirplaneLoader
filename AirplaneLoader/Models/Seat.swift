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
    var seatNumber: Int
    var seatLetter: String {
        return Airplane.seatingAlphabet[seatNumber]
    }
    var id = UUID()
    var business: Bool
    var highlighted = false
    @Published var personInSeat: Person?
    
    var description: String {
        return String(rowNumber + 1) + seatLetter
    }
    
    var occupied: Bool {
        return personInSeat != nil
    }
    
    init(seatType: SeatType, rowNumber: Int, seatNumber: Int, business: Bool = false, personInSeat: Person? = nil) {
        self.business = business
        self.personInSeat = personInSeat
        self.seatType = seatType
        self.rowNumber = rowNumber
        self.seatNumber = seatNumber
    }
    
    static func == (lhs: Seat, rhs: Seat) -> Bool {
        return lhs.id == rhs.id
    }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
