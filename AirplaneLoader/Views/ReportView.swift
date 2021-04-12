//
//  ReportView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/11/21.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject internal var airplane: Airplane
    var body: some View {
        ScrollView {
            ForEach(airplane.getParties(), id: \.self.id) { party in
                HStack {
                    Text("\(party.people[0].name!)'s \(party.partyType.toString()) Party")
                    Spacer()
                    Text("\(party.getSatisfaction(seats: party.seats, rows: airplane.rows)) Satisfaction")
                    Spacer()
                    Text(party.people.count == 1 ? "\(party.people.count) Person" : "\(party.people.count) People")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
            }
            Spacer()
            HStack {
                Spacer()
                Text("\(airplane.getTotalSatisfaction()) Total Satisfaction")
                    .font(.title2)
                Spacer()
            }

                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
        }

    }
}
