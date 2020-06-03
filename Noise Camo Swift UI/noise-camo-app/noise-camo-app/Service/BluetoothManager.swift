//
//  BluetoothManager.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 30/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate  {
    var centralManager: CBCentralManager!
    let batterServiceCBUUID = CBUUID(string: "0x180F")
    let genericServiceCBUUID = CBUUID(string: "0x1800")
    
    let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    var heartRatePeripheral: CBPeripheral!
    
    // Continue setup with: https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
    // Bluetooth service UUIDs: https://www.bluetooth.com/specifications/gatt/services/
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager.delegate = self
    }

    // If powered on, start scanning
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .resetting:
            print("Central.state is resetting")
        case .unsupported:
            print("Central.state is unsupported")
        case .unauthorized:
            print("Central.state is unauthorized")
        case .poweredOff:
            print("Central.state is poweredOff")
        case .poweredOn:
//            centralManager.scanForPeripherals(withServices:
//                [batterServiceCBUUID, genericServiceCBUUID, heartRateServiceCBUUID])
//            centralManager.scanForPeripherals(withServices: nil)
//            centralManager.scanForPeripherals(withServices: [EarphonePeripheral.earphoneUUID])
            print("Central.state is poweredOn")
        case .unknown:
            print("Central.state is unknown")
        @unknown default:
            print("Central.state is unknown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
    }
    
}
