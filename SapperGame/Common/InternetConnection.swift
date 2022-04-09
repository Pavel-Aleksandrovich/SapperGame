//
//  NetworkReachability.swift
//  SapperGame
//
//  Created by pavel mishanin on 07.04.2022.
//

import Foundation
import Network

final class InternetConnection {
    
    private let pathMonitor = NWPathMonitor()
    
    // TODO: make private
    var networkAvailableHandler: ((Bool) -> ())? = nil
    
    init() {
        pathMonitor.pathUpdateHandler = { path in
            
            let status = path.status == NWPath.Status.satisfied
            self.networkAvailableHandler?(!status)
        }
    }
    
    func addInternetStatusListener(complition: @escaping(Bool) -> ()) {
        networkAvailableHandler = complition
        pathMonitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    func removeInternetStatusListener() {
        networkAvailableHandler = nil
        pathMonitor.cancel()
    }
    
    func getInternetStatus() -> Bool {
        return pathMonitor.currentPath.status == NWPath.Status.satisfied
    }
}

