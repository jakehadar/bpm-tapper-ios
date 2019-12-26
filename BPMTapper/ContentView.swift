//
//  ContentView.swift
//  BPMTapper
//
//  Created by James Hadar on 12/26/19.
//  Copyright © 2019 James Hadar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isCounting = false
    @State private var lastTap = Date()
    @State private var bpm = 0.0
    
    func tap() {
        guard isCounting else {
            isCounting = true
            return
        }
        bpm = 60 / lastTap.timeIntervalSinceNow.distance(to: 0)
        lastTap = Date()
    }
    
    func reset() {
        isCounting = false
        bpm = 0.0
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                if !self.isCounting {
                    Text("Tap to begin counting.")
                } else {
                    Text("\(Int(bpm.rounded())) BPM")
                        .font(.largeTitle)
                }
            }.frame(height: 100.0)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button("Reset") { self.reset() }
                    .disabled(!self.isCounting)
                
                Spacer()
                
                Button("Tap") { self.tap() }
                
                Spacer()
            }
            
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
