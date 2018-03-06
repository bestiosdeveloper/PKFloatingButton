//
//  PKGlobals.swift
//  PKFloatingButtonDemo
//
//  Created by Pramod Kumar on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import Foundation

class PKGlobals {

    class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
    
    class func getMainQueue(_ closure:@escaping ()->()){
        DispatchQueue.main.async(execute: {
            closure()
        })
    }
    
    class func runInBackgroundQueue(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: block)
    }
}
