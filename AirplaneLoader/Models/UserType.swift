//
//  UserType.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/3/21.
//

import Foundation
import SwiftUI

enum UserType: String, Equatable, CaseIterable {
    case Passenger = "Passenger"
    case CheckInAgent = "Check In Agent"
    case Manager = "Manager"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }

}
