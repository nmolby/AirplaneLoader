//
//  ContentView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var airplane = Airplane()
    @State internal var partyToShow: Party? = nil
    @State internal var userType: UserType = UserType.Manager
    
    var body: some View {
        VStack{
            HStack {
                AirplaneView(airplane: airplane, partyToShow: $partyToShow, userType: $userType)
                VStack {
                    UserTypePicker(userType: $userType, partyToShow: $partyToShow)
                    Spacer()
                }
            }
            Spacer()
            AddPartyView(rows: $airplane.rows, inefficientSeatPicker: SeatPickerFunctions.recursiveSeatPicker, efficientSeatPicker: SeatPickerFunctions.basicSeatPicker, partyToShow: $partyToShow, userType: $userType)
            Spacer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
