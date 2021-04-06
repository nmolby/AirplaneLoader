//
//  LegendView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/5/21.
//

import SwiftUI

struct LegendView: View {
    @Binding internal var userType: UserType
    var body: some View {
        switch(userType) {
        case .Passenger:
            VStack {
                HStack {
                    VStack {
                        Text("Your Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        Spacer()
                        SeatLegendView(backgroundColor: Color.PARTY_SEAT_COLOR, circleColor: Color.PARTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Occupied Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        Spacer()
                        SeatLegendView(backgroundColor: Color.OCCUPIED_SEAT_COLOR, circleColor: Color.OCCUPIED_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
                HStack {
                    VStack {
                        Text("Empty Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        Spacer()
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Business Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        Spacer()
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.BUSINESS_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
            }
        case .CheckInAgent, .Manager:
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        Text("Very Satisfied")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.VERY_HIGH_SATISFACTION_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
                HStack {
                    VStack {
                        Text("Satisfied")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.HIGH_SATISFACTION_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Unsatisfied")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.LOW_SATISFACTION_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
                HStack {
                    VStack {
                        Text("Very Unsatisfied")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.VERY_LOW_SATISFACTION_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Family Party")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.FAMILY_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
                HStack {
                    VStack {
                        Text("Business Party")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.BUSINESS_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Tourist Party")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.TOURIST_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
                HStack {
                    VStack {
                        Text("Empty Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.DEFAULT_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                    VStack {
                        Text("Business Seat")
                            .font(.system(size:11))
                            .multilineTextAlignment(.center)
                        SeatLegendView(backgroundColor: Color.EMPTY_SEAT_COLOR, circleColor: Color.EMPTY_SEAT_COLOR, borderColor: Color.BUSINESS_BORDER_COLOR)
                    }
                    .frame(width: 60, height: 60)
                }
            }

        }
    }
}
