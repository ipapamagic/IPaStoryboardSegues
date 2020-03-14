//
//  IPaContainerViewController.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2019/1/3.
//

import UIKit

open class IPaContainerViewController: IPaContainerBaseViewController{
    
    open var currentViewController: UIViewController?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    open func gotoViewController(_ identifier:String) {
        if let viewController = self.viewControllers[identifier] {
            self.gotoViewController(identifier, destination: viewController)
        }
        else {
            self.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    open override func gotoViewController(_ identifier:String?,destination:UIViewController)
    {
        if self.currentViewController == destination {
            return
        }
         
         
        if let leavingController = self.currentViewController {
            leavingController.willMove(toParent: nil)
            leavingController.view.removeFromSuperview()
            leavingController.removeFromParent()
               
        }
        if let identifier = identifier {
            self.viewControllers[identifier] = destination
        }
        self.currentViewController = destination
        
        self.addChild(destination)
        destination.view.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict:[String:UIView] = ["destView": destination.view]
           
        self.containerView.addSubview(destination.view)
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[destView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[destView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
           destination.didMove(toParent: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
