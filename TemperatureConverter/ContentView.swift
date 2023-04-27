//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Ivan Yarmoliuk on 4/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var from: String = "Celsius"
    @State private var to: String = "Fahrenheit"
    @State private var temperature: Double = 0
    
    let temperatureUnits: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    let table: [String:UnitTemperature] = ["Celsius": UnitTemperature.celsius,
                                           "Fahrenheit":  UnitTemperature.fahrenheit,
                                           "Kelvin":UnitTemperature.kelvin]
    
    @FocusState private var amountIsFocused: Bool
    
    var finalResult: String {
        var teperatureIn = Measurement(value: self.temperature, unit: table[self.from] ?? UnitTemperature.celsius)
        let result = teperatureIn.converted(to: table[self.to] ?? UnitTemperature.celsius).value
    
        return String(format: "%.1f", result)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert from:", selection: $from) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Choose unit you need to convert from:")
                }
                
                Section {
                    Picker("Convert to:", selection: $to) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Choose unit you need to convert to:")
                }
                
                Section {
                    TextField("Amount", value: $temperature, format: .number)
                } header: {
                    Text("Enter your \(from) temperature Here:")
                }
                .focused($amountIsFocused)
                .keyboardType(.decimalPad)
                
                Section {
                    Text("\(finalResult) \(to)")
                } header: {
                    Text("Your result is :")
                }
                
            }
            .navigationTitle("WeTemp")
            .toolbar {
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
