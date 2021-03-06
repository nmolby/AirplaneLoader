//
//  ContentView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var airplane = Airplane() //Airplane.getRandomAirplane()
    @State internal var partyToShow: Party? = nil
    @State internal var userType: UserType = UserType.Passenger
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    AirplaneView(airplane: airplane, partyToShow: $partyToShow, userType: $userType)
                    VStack {
                        UserTypeButton(userType: $userType, partyToShow: $partyToShow)
                        if(userType == UserType.Manager) {
                            GenerateReportButton(airplane: airplane)
                        } 
                        LegendView(userType: $userType)
                    }
                }
                Spacer()
                AddPartyView(rows: $airplane.rows, inefficientSeatPicker: SeatPickerFunctions.recursiveSeatPicker, efficientSeatPicker: SeatPickerFunctions.familySeatPicker, partyToShow: $partyToShow, userType: $userType)
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
