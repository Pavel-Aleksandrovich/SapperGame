//
//  NetworkReachability.swift
//  SapperGame
//
//  Created by pavel mishanin on 07.04.2022.
//

import Foundation
import Network

final class InternetConnection {
    
    private var pathMonitor: NWPathMonitor!
    private var path: NWPath?
    
    
    private var networkAvailable: Bool = false {
        didSet {
            networkAvailableHandler?(networkAvailable)
        }
    }
    
    var networkAvailableHandler: ((Bool) -> ())?
    
    private lazy var pathUpdateHandler: ((NWPath) -> ()) = { path in
        self.path = path
        
        if path.status == NWPath.Status.satisfied {
            self.networkAvailable = false
        } else  {
            self.networkAvailable = true
        }
    }
    
    private let backgroudQueue = DispatchQueue.global(qos: .background)
    
    init() {
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = self.pathUpdateHandler
        pathMonitor.start(queue: backgroudQueue)
//        networkAvailable = isNetworkAvailable()
    }
    
    func isNetworkAvailable() -> Bool {
        if let path = self.path {
            if path.status == NWPath.Status.satisfied {
                networkAvailable = true
                return true
            }
        }
        networkAvailable = false
        return false
    }
}
