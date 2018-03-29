//
//  IPaContainerGotoSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2018/3/29.
//

import UIKit
public protocol IPaContainerProtocol  {
    var currentViewController:UIViewController? {get set}
    var containerView:UIView! {get set}
}

open class IPaContainerGotoSegue: UIStoryboardSegue {
    var baseViewController:(IPaContainerProtocol & UIViewController)? {
        get {
            var source:UIViewController? = self.source
            while source != nil && !(source is IPaContainerProtocol) {
                source = source?.parent
            }
            return source as? UIViewController & IPaContainerProtocol
        }
    }
    override open func perform()
    {
        guard var source = baseViewController else {
            return
        }
        if let leavingController = source.currentViewController {
            leavingController.willMove(toParentViewController: nil)
            leavingController.view.removeFromSuperview()
            leavingController.removeFromParentViewController()
            
        }
        let destination = self.destination
        source.currentViewController = destination
        source.addChildViewController(destination)
        destination.view.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict:[String:UIView] = ["destView": destination.view]
        
        source.containerView.addSubview(destination.view)
        source.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[destView]|",options:NSLayoutFormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        source.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[destView]|",options:NSLayoutFormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        destination.didMove(toParentViewController: source)
    }
}
