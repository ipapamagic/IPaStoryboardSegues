//
//  IPaContainerGotoSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2018/3/29.
//

import UIKit
public protocol IPaViewContainerProtocol  {
    func gotoViewController(_ identifier:String?,destination:UIViewController)
}

open class IPaContainerGotoSegue: UIStoryboardSegue {
    var baseViewController:(IPaViewContainerProtocol & UIViewController)? {
        get {
            var source:UIViewController? = self.source
            while source != nil && !(source is IPaViewContainerProtocol) {
                source = source?.parent
            }
            return source as? UIViewController & IPaViewContainerProtocol
        }
    }
    override open func perform()
    {
        let destination = self.destination
        guard let baseViewController = baseViewController else {
            return
        }
        baseViewController.gotoViewController(self.identifier, destination: destination)
    }
}
