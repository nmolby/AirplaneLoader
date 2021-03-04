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
            AddPartyView(seats: $airplane.seats, seatPicker: basicSeatPicker)
            Button("print airplane state") {
                print(airplane.seats[0])
            }
        }
    }
    
    func basicSeatPicker(seats: [[Seat]], party: Party) -> [Seat] {
        var seatsToAdd : [Seat] = []
        for person in party.people {
            for row in seats {
                var foundSeat = false
                for seat in row {
                    if(!seat.occupied) {
                        seatsToAdd.append(seat)
                        seat.personInSeat = person
                        print("found seat for \(seat.personInSeat!.name)")
                        foundSeat = true
                        break
                    } 
                }
                if(foundSeat) {
                    break
                }
            }
        }
        
        return seatsToAdd
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
