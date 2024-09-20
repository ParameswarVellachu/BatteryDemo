//
//  BatteryMonitoringViewController.swift
//  BatteryDemo
//
//  Created by Parameswaran on 04/09/24.
//

import UIKit

enum BatteryLevel: String {
    case unplugged = "unplugged"
    case charging = "charging"
    case full = "full"
    case unknown = "unknown"
}

class BatteryMonitoringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelDidChange),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateDidChange),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        
        // Get the current battery level
        print("Battery Level: \(UIDevice.current.batteryLevel * 100)%")
        // Get the current battery state
        print("Battery State: \(UIDevice.current.batteryState.rawValue)")
        
        alertBox(title: .charging, message: "Battery State: Charging")
        
    }
    
    func alertBox(title: BatteryLevel, message: String) {
        
        let alert=UIAlertController(title: title.rawValue, message: message, preferredStyle: UIAlertController.Style.alert )

        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {
                alert in
            print(alert.title!)
        }))

        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func batteryLevelDidChange(notification: NSNotification) {
        print("Battery Level Changed: \(UIDevice.current.batteryLevel * 100)%")
    }
    
    @objc func batteryStateDidChange(notification: NSNotification) {
        
        switch UIDevice.current.batteryState {
            
        case .unplugged:
            print("Battery State: Unplugged")
            alertBox(title: .unplugged, message: "Battery State: Unplugged")
            
        case .charging:
            print("Battery State: Charging")
            alertBox(title: .charging, message: "Battery State: Charging")

        case .full:
            print("Battery State: Full")
            alertBox(title: .full, message: "Battery State: Full")

        case .unknown:
            print("Battery State: Unknown")
            alertBox(title: .unknown, message: "Battery State: Unknown")

        @unknown default:
            print("Battery State: Unknown")
        }
    }
}


