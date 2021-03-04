//
//  SeatImageView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/4/21.
//

import Foundation
import SwiftUI

struct SeatImageView: View {
    @State internal var occupied: Bool
    
    var body: some View {
        if occupied {
            Image(systemName: "square.fill")
        } else {
            Image(systemName: "square")
        }
    }
}
