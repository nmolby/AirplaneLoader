//
//  GenerateReportButton.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/11/21.
//

import SwiftUI

struct GenerateReportButton: View {
    @ObservedObject internal var airplane: Airplane
    var body: some View {
        NavigationLink(destination: ReportView(airplane: airplane)) {
            Text("Generate Report")
                .font(.footnote)

        }
        .foregroundColor(Color.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
    }
}
