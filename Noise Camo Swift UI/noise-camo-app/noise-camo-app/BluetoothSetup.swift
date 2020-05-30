//
//  BluetoothSetup.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 30/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import CoreBluetooth

struct BluetoothSetup: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("Set up bluetooth")
                    .foregroundColor(.white)
            }
        }
    }
}

struct BluetoothSetup_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothSetup(bluetoothManager: BluetoothManager())
    }
}
