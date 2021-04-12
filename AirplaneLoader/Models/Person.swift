//
//  Person.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 3/3/21.
//

import Foundation

struct Person {
    var name: String?
    var id = UUID()
    var party: Party
}

func randomNames() -> [String] {
    if let filepath = Bundle.main.path(forResource: "first-names", ofType: "txt") {
        do {
            let nameString = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
            var names: [String] = []
            nameString.enumerateLines() { line, _ in
                names.append(line)
            }
            return names
        } catch {
            print("AHHHH")
            return []
            
        }
    } else {
        print("AHHHH")
        return []
        
    }
    
}
