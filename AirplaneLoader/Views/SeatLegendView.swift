//
//  SeatLegendView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/5/21.
//

import SwiftUI

struct SeatLegendView: View {
    internal var backgroundColor: Color
    internal var circleColor: Color
    internal var borderColor: Color
    
    var body: some View {
        ZStack{
            Image(systemName: "square.fill")
                .foregroundColor(circleColor)
            Image(systemName: "circle.fill.square.fill")
                .foregroundColor(backgroundColor)
            Image(systemName: "square")
                .foregroundColor(borderColor)
        }
    }
}
