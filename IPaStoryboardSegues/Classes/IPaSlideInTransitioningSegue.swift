//
//  IPaSlideInTransitioningSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit
import ObjectiveC
@IBDesignable
open class IPaSlideInTransitioningSegue: UIStoryboardSegue {
    private var associatedObjectHandle: UInt8 = 0
    @IBInspectable open var animationDuration:TimeInterval = 0.3
    open var slideInDirection:IPaSlideInDirection = .left
    @IBInspectable open var contentSize:CGSize = .zero
    var transitionController:IPaSlideInTransition {
        get {
            guard let controller =  objc_getAssociatedObject(self.destination, &associatedObjectHandle) as? IPaSlideInTransition else {
                let controller = IPaSlideInTransition()
                self.transitionController = controller
                return controller
            }
            return controller
        }
        set {
            objc_setAssociatedObject(self.destination, &associatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    override open func perform() {
        let transitionController = self.transitionController
        var contentSize = self.contentSize
        if contentSize.width == 0 {
            contentSize.width = UIScreen.main.bounds.width
        }
        if contentSize.height == 0 {
            contentSize.height = UIScreen.main.bounds.height
        }
        transitionController.contentSize = contentSize
        transitionController.animationDuration = self.animationDuration
        transitionController.slideDirection = self.slideInDirection
        
        self.destination.modalPresentationStyle = .custom
        self.destination.transitioningDelegate = transitionController
        self.source.present(self.destination, animated: true, completion: nil)
    }
}
