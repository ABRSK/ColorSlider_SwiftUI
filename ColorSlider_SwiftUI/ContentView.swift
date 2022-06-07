//
//  ContentView.swift
//  ColorSlider_SwiftUI
//
//  Created by Андрей Барсук on 07.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    private func randomizeColor() {
        redValue = Double.random(in: 0...255)
        greenValue = Double.random(in: 0...255)
        blueValue = Double.random(in: 0...255)
    }
    
    var body: some View {
        VStack {
            Text("Color Picker").font(.largeTitle)
            Text("R: \(lround(redValue)), G: \(lround(greenValue)), B: \(lround(blueValue))")
                .font(.subheadline)
            
            Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 2))
            
            ColorSliderView(colorValue: $redValue, color: .red)
            ColorSliderView(colorValue: $greenValue, color: .green)
            ColorSliderView(colorValue: $blueValue, color: .blue)

            Button(action: randomizeColor) {
                Text("Random Color").font(.title)
            }
            
            Spacer()
        }
        .padding()
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    hideKeyboard()
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

struct ColorSliderView: View {
    @Binding var colorValue: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(colorValue))")
                .frame(width: 50, alignment: .trailing)
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(color)
                .animation(.default, value: colorValue)
            TextField("0", value: $colorValue, format: .number.rounded(rule: .toNearestOrEven, increment: 1))
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .keyboardType(.numberPad)
                .onChange(of: colorValue) { newValue in
                    if newValue > 255 || Int(newValue) != 0 {
                        colorValue = 255
                    }
                }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
