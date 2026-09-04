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

// MARK: - EQ BLE Constants
// TODO: Replace placeholder UUIDs and command byte once the hardware spec is available.
// Capture correct values by sniffing the official Noise Camo app with nRF Connect or LightBlue
// while changing EQ settings, then update the three constants below.

private enum NoiseCamoBLE {
    /// The service UUID the headphone advertises for EQ control.
    /// Currently using the known device UUID as a placeholder — confirm with spec.
    static let eqServiceUUID       = CBUUID(string: "859BB996-F5EB-D179-6ABB-FAAC7E91CC2E")

    /// The characteristic UUID to write EQ payloads to.
    /// TODO: Replace with the actual characteristic UUID from the hardware spec.
    static let eqCharacteristicUUID = CBUUID(string: "00000000-0000-0000-0000-000000000000")

    /// The number of EQ bands the headphone accepts.
    static let bandCount = 6
}

// MARK: - BluetoothManager

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    // MARK: Published state

    /// Whether the manager is actively scanning for the headphone.
    @Published var isScanning: Bool = false

    /// Whether a headphone peripheral is currently connected.
    @Published var isConnected: Bool = false

    /// Human-readable name of the connected peripheral, if any.
    @Published var connectedPeripheralName: String?

    // MARK: Private BLE state

    var centralManager: CBCentralManager!

    private var headphonePeripheral: CBPeripheral?

    /// The characteristic used to write EQ data.
    /// Populated after service/characteristic discovery completes.
    private var eqCharacteristic: CBCharacteristic?

    // MARK: Legacy UUIDs (kept for reference)
    let batteryServiceCBUUID = CBUUID(string: "0x180F")
    let genericServiceCBUUID = CBUUID(string: "0x1800")

    // MARK: Init

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - Scanning

    /// Starts scanning for the Noise Camo headphone.
    func startScanning() {
        guard centralManager.state == .poweredOn else { return }
        isScanning = true
        centralManager.scanForPeripherals(withServices: [NoiseCamoBLE.eqServiceUUID])
    }

    /// Stops an active scan.
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
    }

    // MARK: - EQ Interface

    /// Sends a set of EQ gain values to the headphone over BLE.
    ///
    /// - Parameter gains: Array of `Double` gain values, one per band.
    ///   Must contain exactly `NoiseCamoBLE.bandCount` elements.
    ///   Expected range per band: TBD from hardware spec (e.g. -12.0 to +12.0 dB).
    ///
    /// Call this whenever `EqualizerService.currentGain` changes.
    ///
    /// TODO: Implement `buildEQPayload(from:)` once the byte format is known.
    func sendEQ(gains: [Double]) {
        guard isConnected,
              let peripheral = headphonePeripheral,
              let characteristic = eqCharacteristic
        else {
            print("BluetoothManager.sendEQ: not ready — peripheral or characteristic unavailable")
            return
        }

        guard gains.count == NoiseCamoBLE.bandCount else {
            print("BluetoothManager.sendEQ: expected \(NoiseCamoBLE.bandCount) bands, got \(gains.count)")
            return
        }

        let payload = buildEQPayload(from: gains)
        peripheral.writeValue(payload, for: characteristic, type: .withResponse)
    }

    /// Serialises gain values into the binary payload expected by the headphone.
    ///
    /// TODO: Replace the placeholder implementation with the real byte format.
    /// Once the spec is available, fill in:
    ///   - Command / header byte(s)
    ///   - Gain encoding (e.g. Int8 offset, fixed-point, 0–255 range)
    ///   - Any checksum or terminator bytes
    ///
    /// - Parameter gains: Validated array of `NoiseCamoBLE.bandCount` gain values.
    /// - Returns: `Data` to write to the EQ characteristic.
    private func buildEQPayload(from gains: [Double]) -> Data {
        // PLACEHOLDER — returns empty data until spec is known.
        // Example structure (to be confirmed):
        //   byte 0:   command identifier  (e.g. 0x01)
        //   bytes 1–6: one byte per band, gain encoded as (gain + offset) clamped to 0–255
        return Data()
    }
}

// MARK: - CBCentralManagerDelegate

extension BluetoothManager {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth powered on — ready to scan")
        case .poweredOff:
            print("Bluetooth powered off")
            isConnected = false
            isScanning = false
        case .unauthorized:
            print("Bluetooth unauthorized — check Info.plist NSBluetoothAlwaysUsageDescription")
        case .unsupported:
            print("Bluetooth unsupported on this device")
        case .resetting:
            print("Bluetooth resetting")
        case .unknown:
            print("Bluetooth state unknown")
        @unknown default:
            print("Bluetooth state unknown (future case)")
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        print("Discovered peripheral: \(peripheral.name ?? "unnamed") (\(peripheral.identifier))")

        // TODO: Optionally filter by peripheral.name if the headphone advertises a known name.
        headphonePeripheral = peripheral
        headphonePeripheral?.delegate = self
        stopScanning()
        centralManager.connect(peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "peripheral")")
        isConnected = true
        connectedPeripheralName = peripheral.name
        // Discover only the EQ service to avoid unnecessary discovery overhead.
        peripheral.discoverServices([NoiseCamoBLE.eqServiceUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect: \(error?.localizedDescription ?? "unknown error")")
        isConnected = false
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral.name ?? "peripheral"): \(error?.localizedDescription ?? "clean disconnect")")
        isConnected = false
        connectedPeripheralName = nil
        eqCharacteristic = nil
        headphonePeripheral = nil
    }
}

// MARK: - CBPeripheralDelegate

extension BluetoothManager {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Service discovery error: \(error.localizedDescription)")
            return
        }

        guard let services = peripheral.services else { return }

        for service in services {
            print("Discovered service: \(service.uuid)")
            if service.uuid == NoiseCamoBLE.eqServiceUUID {
                peripheral.discoverCharacteristics([NoiseCamoBLE.eqCharacteristicUUID], for: service)
            }
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService,
        error: Error?
    ) {
        if let error = error {
            print("Characteristic discovery error: \(error.localizedDescription)")
            return
        }

        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            print("Discovered characteristic: \(characteristic.uuid)")
            if characteristic.uuid == NoiseCamoBLE.eqCharacteristicUUID {
                eqCharacteristic = characteristic
                print("EQ characteristic ready — sendEQ() calls will now be forwarded to the headphone")
            }
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didWriteValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        if let error = error {
            print("EQ write failed: \(error.localizedDescription)")
        } else {
            print("EQ payload written successfully")
        }
    }
}
