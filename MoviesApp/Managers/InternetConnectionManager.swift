//
//  InternetConnectionManager.swift
//  MoviesApp
//
//  Created by Zachary on 3/4/24.
//

import Foundation
import Network

class InternetConnectionManager {
    static let shared = InternetConnectionManager()
    let monitor = NWPathMonitor()
    var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
