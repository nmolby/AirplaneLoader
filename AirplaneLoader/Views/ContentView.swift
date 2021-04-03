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
    @State internal var partyClickedOn: Party? = nil
    
    var body: some View {
        VStack{
            AirplaneView(airplane: airplane, partyClickedOn: $partyClickedOn)
            Spacer()
            AddPartyView(rows: $airplane.rows, inefficientSeatPicker: SeatPickerFunctions.recursiveSeatPicker, efficientSeatPicker: SeatPickerFunctions.basicSeatPicker, canAddMultipleCustomers: true, partyClickedOn: $partyClickedOn)
            Spacer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
