//
//  IPaReplaceRootSegue.swift
//  Pods
//
//  Created by IPa Chen on 2017/5/2.
//
//

import UIKit

open class IPaReplaceRootSegue: UIStoryboardSegue {
    override open func perform() {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        window?.rootViewController = self.destination
        
    }
}
