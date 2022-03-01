//
//  ContentView.swift
//  WeSplit
//
//  Created by gfaul on 24/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        
        .currency(code: Locale.current.currencyCode ?? "USD")
    }

    var tipValue: Double {
        
        let tipSelection = Double(tipPercentage)
        
        return checkAmount / 100 * tipSelection
    }
    
    var totalAmount: Double {

        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        
        let amountPerPerson = totalAmount / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        
                        ForEach(2 ..< 100) {
                            
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        
                        ForEach(0 ..< 101) {
                            
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    
                    Text(totalAmount, format: currencyCode)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Spacer()
                    
                    Button("Done") {
                        
                        amountIsFocused = false
                    }
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
