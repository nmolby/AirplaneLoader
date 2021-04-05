//
//  UserType.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/3/21.
//

import Foundation
import SwiftUI

enum UserType: String, Equatable, CaseIterable {
    case Passenger = "P"
    case CheckInAgent = "C"
    case Manager = "M"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }

}
