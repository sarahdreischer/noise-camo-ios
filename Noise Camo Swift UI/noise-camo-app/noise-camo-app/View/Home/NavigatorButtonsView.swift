//
//  NavigatorButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 07/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct NavigatorButtonsView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @ObservedObject var viewRouter: ViewRouter
    @State private var setupPresent: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    Button(action: {
                        self.viewRouter.currentView = "equalizer"
                    }) {
                        SingleNavigatorButtonView(buttonText: "equalizer", imageName: "slider.horizontal.3", isSystemName: true)
                    }
                    
                    Button(action: {
                        self.viewRouter.currentView = "player"
                    }) {
                        SingleNavigatorButtonView(buttonText: "player", imageName: "arrowtriangle.right.fill", isSystemName: true)
                    }
                    
                    Button(action: {
                        self.setupPresent = true
                    }) {
                        SingleNavigatorButtonView(buttonText: "bluetooth", imageName: "chevron.left.2", isSystemName: true)
                    }
                }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.height/3)
        .sheet(isPresented: self.$setupPresent) {
            BluetoothSetup(bluetoothManager: self.bluetoothManager)
        }
    }
}

struct NavigatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorButtonsView(bluetoothManager: BluetoothManager(), viewRouter: ViewRouter())
    }
}
