//
//  IPaReplaceSegue.swift
//  Pods
//
//  Created by IPa Chen on 2017/5/2.
//
//

import UIKit
public protocol IPaReplaceSourceWithTarget {
    var replaceTarget:UIViewController { get }
}
open class IPaReplaceSegue: UIStoryboardSegue {
    override open func perform() {
        if let navigationController = self.source.navigationController {
            var replaceTarget = self.source
            if let replaceSource = self.source as? IPaReplaceSourceWithTarget {
                replaceTarget = replaceSource.replaceTarget
            }
            if let index = navigationController.viewControllers.firstIndex(where: {
                viewController in
                return (viewController == replaceTarget)
            }) {
                var viewControllers:[UIViewController]
                if index > 0 {
                    viewControllers = Array(navigationController.viewControllers[0..<index])
                    viewControllers.append(self.destination)
                }
                else {
                    viewControllers = [self.destination]
                }
                navigationController.setViewControllers(viewControllers, animated: true)
            }    
        }
            
    }
}

