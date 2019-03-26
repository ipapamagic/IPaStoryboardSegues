//
//  IPaReplaceSegue.swift
//  Pods
//
//  Created by IPa Chen on 2017/5/2.
//
//

import UIKit

open class IPaReplaceSegue: UIStoryboardSegue {
    override open func perform() {
        if let navigationController = self.source.navigationController {
            if let index = navigationController.viewControllers.firstIndex(where: {
                viewController in
                return (viewController == self.source)
            }) {
                var viewControllers:[UIViewController]
                if index > 0 {
                    viewControllers = Array(navigationController.viewControllers[0...index])
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

