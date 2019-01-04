//
//  IPaContainerViewController.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2019/1/3.
//

import UIKit

open class IPaContainerViewController: UIViewController ,IPaViewContainerProtocol{
    public var currentViewController: UIViewController?
    
    @IBOutlet public weak var containerView: UIView!
    

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    open func gotoView(_ identifier:String,viewController:UIViewController) {
        if self.currentViewController == viewController {
            return
        }
        let segue = IPaContainerGotoSegue(identifier: identifier, source: currentViewController ?? self, destination: viewController)
        
        segue.perform()
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
