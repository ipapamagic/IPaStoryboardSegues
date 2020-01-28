//
//  IPaSuperNavigationPushSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit

open class IPaSuperNavigationPushSegue: UIStoryboardSegue {
    override open func perform() {
        var navigationController:UINavigationController? = self.source.navigationController
        var viewController = self.source
        while navigationController == nil,viewController.parent != nil {
            viewController = viewController.parent!
            navigationController = viewController.navigationController
        }
        if let navigationController = navigationController {
            navigationController.pushViewController(self.destination, animated: true)
        }
        
    }
}
