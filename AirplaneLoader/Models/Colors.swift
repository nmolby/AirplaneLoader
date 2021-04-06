//
//  Colors.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/5/21.
//

import Foundation
import SwiftUI


extension Color {
    static var EMPTY_SEAT_COLOR: Color { return Color.white }
    static var OCCUPIED_SEAT_COLOR: Color { return Color.gray }
    static var PARTY_SEAT_COLOR: Color { return Color.green }
    static var BUSINESS_SEAT_COLOR: Color { return Color.pink }
    static var TOURIST_SEAT_COLOR: Color { return Color.purple }
    static var FAMILY_SEAT_COLOR: Color { return Color(red: 115 / 255, green: 220 / 255, blue: 255 / 255) }
    static var BUSINESS_BORDER_COLOR: Color { return Color.blue }
    static var DEFAULT_BORDER_COLOR: Color { return Color.black }
    static var VERY_LOW_SATISFACTION_COLOR: Color { return Color.red }
    static var LOW_SATISFACTION_COLOR: Color { return Color.yellow }
    static var AVERAGE_SATISFACTION_COLOR: Color { return Color.white }
    static var HIGH_SATISFACTION_COLOR: Color { return Color(red: 0.671875, green: 0.69921875, blue: 0.203125) }
    static var VERY_HIGH_SATISFACTION_COLOR: Color { return Color.green }

}
