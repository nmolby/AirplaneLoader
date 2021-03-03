//
//  AirplaneLoaderApp.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import SwiftUI

@main
struct AirplaneLoaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
