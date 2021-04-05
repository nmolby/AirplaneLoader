//
//  UserTypePicker.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/3/21.
//

import SwiftUI

struct UserTypePicker: View {
    @Binding internal var userType: UserType
    @Binding internal var partyToShow: Party?
    
    var body: some View {
        VStack {
            Picker("", selection: $userType ) {
                ForEach(UserType.allCases, id: \.self) { value in
                    Text(value.localizedName)
                        .tag(value)
                        .rotationEffect(.degrees(-90))
                }
            }.pickerStyle(SegmentedPickerStyle())
            .onReceive([self.userType].publisher.first()) { value in
                        partyToShow = nil
             }

        }

     
    }
}
