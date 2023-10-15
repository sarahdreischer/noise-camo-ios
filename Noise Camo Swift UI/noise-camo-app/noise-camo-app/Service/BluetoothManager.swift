//
//  BluetoothManager.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 30/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//
// Continue setup with:
// https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
// Another useful source:
// http://quabr.com:8182/58145445/implementing-bluetooth-support-with-pure-swift-ui
// Bluetooth service UUIDs:
// https://www.bluetooth.com/specifications/gatt/services/
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate  {
    var centralManager: CBCentralManager!
    let batterServiceCBUUID = CBUUID(string: "0x180F")
    let genericServiceCBUUID = CBUUID(string: "0x1800")
//    let genericServiceCBUUID = CBUUID.init(string: "C7CB6E36-E71D-46D9-B808-89C9D2C247AA")
    let noiseCamoCBUUID = CBUUID.init(string: "859BB996-F5EB-D179-6ABB-FAAC7E91CC2E")
    var anyDevicePeripheral: CBPeripheral!
    //BF3852E5-F166-7E22-8CF8-D97AEFED9A10
    
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
            print("Central.state is poweredOn")
            centralManager.scanForPeripherals(withServices: [batterServiceCBUUID])
        case .unknown:
            print("Central.state is unknown")
        @unknown default:
            print("Central.state is unknown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print(peripheral)
//        if !(peripheral.name?.contains("Mac") ?? true || peripheral.name?.contains("TV") ?? true || peripheral.name?.contains("Sarah") ?? true) {
            print(peripheral)
//        }
        //C072105F-A4F6-2727-A1E2-C231D4A800AB
//        anyDevicePeripheral = peripheral
//        centralManager.stopScan()
//        centralManager.connect(anyDevicePeripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        anyDevicePeripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
          print(service)
        }
    }
    
}
