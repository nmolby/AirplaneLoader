//
//  PassengerTicketView.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/2/21.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct PassengerTicketView: View {
    let person: Person
    let seat: Seat
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        VStack {
            PassengerTicketDetailView(description: "Seat", value: seat.description)
            PassengerTicketDetailView(description: "Class", value: seat.business ? "Business" : "Economy")
            PassengerTicketDetailView(description: "Flight", value: "UA 423")
            PassengerTicketDetailView(description: "Gate", value: "14A")
            PassengerTicketDetailView(description: "Departure", value: "Columbus")
            PassengerTicketDetailView(description: "Destination", value: "Mars")
            Image(uiImage: generateQRCode(from: "\(seat.personInSeat!.name!)\nUA 423"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Spacer()


        }
        .navigationBarTitle(person.name!)
    }
    
    //from https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct PassengerTicketDetailView: View {
    let description: String
    let value: String
    
    var body: some View {
        HStack {
            Text(description)
                .font(.title)
                .fontWeight(.light)
            Spacer()
            Text(value)
                .font(.title)
        }
        .padding([.leading, .trailing])
    }
}
