//
//  IPaPageContainerViewController.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2019/12/8.
//

import UIKit

open class IPaPageContainerViewController: IPaContainerBaseViewController {
    open var pageIdList = [String]()
    open lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        
        let child:UIViewController = pageController
        child.willMove(toParent: parent)
        self.addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict:[String:UIView] = ["childView": child.view]
        containerView.addSubview(child.view)
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",options:NSLayoutConstraint.FormatOptions(rawValue: 0),metrics:nil,views:viewsDict))
        child.didMove(toParent: parent)
        return pageController
    }()
    open var currentIdentifier:String? {
        get {
            guard let viewController = self.pageController.viewControllers?.first,let identifier = self.getIdentifier(of: viewController) else {
                return nil
            }
            return identifier
        }
    }
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    open func gotoPage(_ identifier:String) {
        let viewController:UIViewController = self.getViewController(identifier)
        self.gotoViewController(identifier, destination: viewController)
        
    }
    open override func gotoViewController(_ identifier:String?,destination:UIViewController) {
        guard let identifier = identifier,let gotoIndex = self.pageIdList.firstIndex(of: identifier) else {
            return
        }
        var direction = UIPageViewController.NavigationDirection.forward
        var oldIdentifier = ""
        if let currentIdentifier = self.currentIdentifier ,let currentIndex = self.pageIdList.firstIndex(of: currentIdentifier) {
            oldIdentifier = currentIdentifier
            if gotoIndex > currentIndex {
                direction = UIPageViewController.NavigationDirection.forward
            }
            else if gotoIndex < currentIndex {
                direction = UIPageViewController.NavigationDirection.reverse
            }
            else {
                return
            }
        }
        self.pageController.setViewControllers([destination], direction: direction, animated: true, completion:{
            finished in
            self.onGoto(from: oldIdentifier, to: identifier)
        })
    }
    open func onGoto(from oldIdentifier:String,to identifier:String) {
        
    }
    open func initial(_ viewController:UIViewController, identifier:String) {
        
    }
    open func createViewControler(_ identifier:String) -> UIViewController {
        return (storyboard?.instantiateViewController(withIdentifier: identifier))!
    
    }
    open func getViewController(_ identifier:String) -> UIViewController{
        if let vc = self.viewControllers[identifier] {
            return vc
        }
        let viewController = createViewControler(identifier)
        self.initial(viewController,identifier: identifier)
        
        self.viewControllers[identifier] = viewController
        return viewController
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            self.initial(segue.destination, identifier: identifier)
            self.viewControllers[identifier] = segue.destination
            
        }
    }
    

}
extension IPaPageContainerViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource
{
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentIdentifier = self.currentIdentifier ,let index = self.pageIdList.firstIndex(of: currentIdentifier) ,index > 0 {
            let afterKey = pageIdList[index - 1]
            
            return self.getViewController(afterKey)
            
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentIdentifier = self.currentIdentifier ,let index = self.pageIdList.firstIndex(of: currentIdentifier) ,index < self.pageIdList.count - 1 {
            let afterKey = pageIdList[index + 1]
            
            return self.getViewController(afterKey)
            
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        var fromIdentifier = ""
        for identifier in self.pageIdList {
            if self.viewControllers[identifier] == previousViewControllers.first {
                fromIdentifier = identifier
            }
            
        }
        guard let currentIdentifier = currentIdentifier ,fromIdentifier != currentIdentifier else {
            return
        }
        self.onGoto(from: fromIdentifier, to: self.currentIdentifier ?? "")
    }
}

