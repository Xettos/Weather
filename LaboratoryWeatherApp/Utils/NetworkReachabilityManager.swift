//
//  NetworkReachability.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 08.10.2020.
//

import Foundation
import Reachability

protocol NetworkReachabilityProtocol {
     func isReachable(completed: @escaping (NetworkReachabilityManager) -> Void)
    func isUnreachable(completed: @escaping (NetworkReachabilityManager) -> Void)
}

class NetworkReachabilityManager: NSObject, NetworkReachabilityProtocol {
    
    var reachability: Reachability!
    static let sharedInstance: NetworkReachabilityManager = {
        return NetworkReachabilityManager()
    }()
    override init() {
        super.init()
        // Initialise reachability
        try! reachability = Reachability()
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkReachabilityManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
     func isReachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    // Network is unreachable
     static func isUnreachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
}

extension NetworkReachabilityProtocol {
    // Network is reachable
     func isReachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    // Network is unreachable
    func isUnreachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
}
