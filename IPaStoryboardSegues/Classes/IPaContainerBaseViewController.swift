//
//  IPaContainerBaseViewController.swift
//  FirebaseCore
//
//  Created by IPa Chen on 2020/1/17.
//

import UIKit

open class IPaContainerBaseViewController: UIViewController ,IPaViewContainerProtocol{
    public var viewControllers: [String : UIViewController]! = [String:UIViewController]()
    
    @IBOutlet open weak var containerView: UIView!
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override open func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let viewController = self.viewControllers[identifier] {
            self.gotoViewController(identifier, destination: viewController)
            return false
        }
        return true
    }
    open func getIdentifier(of viewController:UIViewController) -> String? {
        if let entry = self.viewControllers.first(where: { (arg) -> Bool in
            
            let (_, v) = arg
            return v == viewController
        }) {
            return entry.key
        }
        return nil
    }
    open func gotoViewController(_ identifier:String?,destination:UIViewController)
    {
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
