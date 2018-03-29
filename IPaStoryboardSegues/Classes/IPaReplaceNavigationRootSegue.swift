//
//  IPaReplaceNavigationRootSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2018/3/23.
//

import UIKit

open class IPaReplaceNavigationRootSegue: UIStoryboardSegue {
    override open func perform() {
        if let navigationController = self.source.navigationController {
            navigationController.setViewControllers([self.destination], animated: true)
        }
        
    }
}
