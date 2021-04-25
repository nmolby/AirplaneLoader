//
//  UserTypePicker.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/3/21.
//

import SwiftUI

struct UserTypeButton: View {
    @Binding internal var userType: UserType
    @Binding internal var partyToShow: Party?
    
    var body: some View {
        NavigationLink("Change User", destination: LoginView(applicationUserType: $userType, partyToShow: $partyToShow))
            .foregroundColor(Color.white)
            .font(.footnote)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue))
    }
}
