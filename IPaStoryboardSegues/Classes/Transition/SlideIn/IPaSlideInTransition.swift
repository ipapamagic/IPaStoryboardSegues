//
//  IPaTransitionSlideIn.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit
public enum IPaSlideInDirection:Int {
    case up = 0
    case down = 1
    case left = 2
    case right = 3
}
protocol IPaSlideInInfo
{
    var contentSize:CGSize { get }
    
    var slideDirection:IPaSlideInDirection { get }
    var animationDuration:TimeInterval { get }
}
class IPaSlideInTransition: NSObject,UIViewControllerTransitioningDelegate,IPaSlideInInfo {
    var contentSize: CGSize = .zero
    var slideDirection: IPaSlideInDirection = .left
    var animationDuration: TimeInterval = 0.3
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = IPaSlideInPresentationController(presentedViewController: presented,
                                                                     presenting: presenting,slideDelegate: self)
        
        return presentationController
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return IPaSlideInAnimator(isPresentation: true,  delegate: self)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return IPaSlideInAnimator(isPresentation: false,  delegate: self)
    }
}
