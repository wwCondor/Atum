//
//  Reachability.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import SystemConfiguration

struct Reachability {
    // Object that checks internet connection
    private static let reachability = SCNetworkReachabilityCreateWithName( kCFAllocatorDefault, "https://api.nasa.gov/")
    
    static func checkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        var isReachable: Bool = false
        
        if (isNetworkReachable(with: flags)) {
            if flags.contains(.isWWAN) {
                isReachable = true
            } else {
                isReachable = true
            }
    
        } else if (!isNetworkReachable(with: flags)) {
            isReachable = false
        }
        
        return isReachable
    }
    
    private static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachble = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachble && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
