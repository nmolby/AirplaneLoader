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
    
    var body: some View {
        VStack{
            AirplaneView(airplane: airplane)
            AddPartyView(rows: $airplane.rows, seatPicker: basicSeatPicker)
        }
    }
    
    func basicSeatPicker(rows: [Row], party: inout Party) -> [Seat] {
        var seatsToAdd : [Seat] = []
        for person in party.people {
            for row in rows {
                var foundSeat = false
                for seat in row.seats {
                    if(!seat.occupied) {
                        seatsToAdd.append(seat)
                        seat.personInSeat = person
                        foundSeat = true
                        break
                    } 
                }
                if(foundSeat) {
                    break
                }
            }
        }
        party.seats = seatsToAdd
        
        return seatsToAdd
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
