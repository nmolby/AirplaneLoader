//
//  LoginView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/25/21.
//

import SwiftUI

enum LoginState {
    case Failed
    case NoAttempt
}

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding internal var applicationUserType: UserType
    @Binding internal var partyToShow: Party?
    @State internal var userType = UserType.Passenger
    @State internal var username = ""
    @State internal var password = ""
    @State internal var loginState = LoginState.NoAttempt

    var body: some View {
        Form {
            Picker("", selection: $userType ) {
                ForEach(UserType.allCases, id: \.self) { value in
                    Text(value.localizedName)
                        .tag(value)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .onReceive([self.applicationUserType].publisher.first()) { value in
                        partyToShow = nil
             }
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("Password", text: $password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            Button("Login") { login() }
            if(loginState == LoginState.Failed) {
                Text("Login Failed")
                    .foregroundColor(.red)

            }
        }
        .navigationBarTitle(Text("Change User"), displayMode: .inline)

    }
    
    func login() {
        if LoginInfo.validate(userType: userType, username: username, password: password) {
            applicationUserType = userType
            self.presentationMode.wrappedValue.dismiss()
        } else {
            loginState = LoginState.Failed
        }
        
    }
}
