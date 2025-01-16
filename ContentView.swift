//
//  ContentView.swift
//  BetterRest
//
//  Created by Pavol Ocelka on 16/01/2025.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    var body: some View {
        ZStack{
            Color(UIColor(hexString: "#F8F4E1")).ignoresSafeArea()
            
                Form{
                    VStack(alignment: .leading){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    VStack(alignment: .leading){
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    VStack(alignment: .leading){
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
                    }
                }
                .padding(.top, 50)
                .scrollContentBackground(.hidden)
                
                Button("Calculate", action: calculateBedtime)
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(UIColor(hexString: "#543310")))
                    .clipShape(.capsule)
                    .alert(alertTitle, isPresented: $showingAlert) {
                        Button("OK") {}
                    } message: {
                        Text(alertMessage)
                    }
                    .padding(.top, 50)
            VStack{
                HStack{
                    Text("Better Rest")
                        .foregroundStyle(Color(UIColor(hexString: "#543310")))
                        .font(.largeTitle.bold())
                    Spacer()
                }
                Spacer()
            }.padding()
            
        }
    }
    
    func calculateBedtime() {
        do{
            let config = MLModelConfiguration()
            let model = try BetterRest(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch{
            alertTitle = "Error"
            alertMessage = "Sorry , there was an error."
        }
        showingAlert = true
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

#Preview {
    ContentView()
}

