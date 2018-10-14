//
//  IPaContainerGotoSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2018/3/29.
//

import UIKit
public protocol IPaViewContainerProtocol  {
    var currentViewController:UIViewController? {get set}
    var containerView:UIView! {get set}
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
        guard var source = baseViewController , source.currentViewController != destination else {
            return
        }
        if let leavingController = source.currentViewController {
            leavingController.willMove(toParent: nil)
            leavingController.view.removeFromSuperview()
            leavingController.removeFromParent()
            
        }
        
        source.currentViewController = destination
        source.addChild(destination)
        destination.view.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict:[String:UIView] = ["destView": destination.view]
        
        source.containerView.addSubview(destination.view)
        source.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[destView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        source.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[destView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        destination.didMove(toParent: source)
    }
}
