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
    
    private var networkAvailableHandler: ((Bool) -> ())? = nil
    
    init() {
        addInternetStatusListener()
        getPathStatus()
    }
    
    private func getPathStatus() {
        pathMonitor.pathUpdateHandler = { path in
            
            let status = path.status == NWPath.Status.satisfied
            self.networkAvailableHandler?(!status)
        }
    }
    
    private func addInternetStatusListener() {
        pathMonitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    func removeInternetStatusListener() {
        networkAvailableHandler = nil
        pathMonitor.cancel()
    }
    
    func getInternetStatus() -> Bool {
        return pathMonitor.currentPath.status == NWPath.Status.satisfied
    }
    
    func checkInternetStatus(complition: @escaping(Bool) -> ()) {
        let status = getInternetStatus()
        complition(status)
        networkAvailableHandler = complition
    }
}
