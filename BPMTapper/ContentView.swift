//
//  ContentView.swift
//  BPMTapper
//
//  Created by James Hadar on 12/26/19.
//  Copyright © 2019 James Hadar. All rights reserved.
//

import SwiftUI

/// Triggers button action immediately on press (mimicking UIKit's "Touch Down" send event).
struct TapButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
                .foregroundColor(.blue)
                .onLongPressGesture(
                    minimumDuration: 0,
                    perform: configuration.trigger
                )
    }
}

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
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .foregroundColor(Color.clear)
                    .contentShape(Rectangle())
                    .onLongPressGesture(minimumDuration: 0) {
                        self.tap()
                    }
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Text("\(Int(bpm.rounded())) BPM")
                            .font(.largeTitle)
                            .frame(height: 100.0)
                            .padding()
                            .allowsHitTesting(false)
                                                
                        Button("Reset") {
                            self.reset()
                        }
                        .disabled(!self.isCounting)
                        .allowsHitTesting(true)
                        
                        Spacer()
                        if !self.isCounting {
                            Text("Tap anywhere to begin measuring.")
                            Spacer()
                        }
                        
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .light)
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}
#endif
