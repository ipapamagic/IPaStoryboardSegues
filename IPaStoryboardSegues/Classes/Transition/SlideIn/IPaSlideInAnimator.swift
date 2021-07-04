//
//  IPaSlideInAnimator.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit

class IPaSlideInAnimator :NSObject,UIViewControllerAnimatedTransitioning
{
    let delegate:IPaSlideInInfo
    let isPresentation: Bool
    // MARK: - Initializers
    init(isPresentation: Bool,delegate:IPaSlideInInfo) {
        self.isPresentation = isPresentation
        self.delegate = delegate
        super.init()
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.delegate.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch self.delegate.slideDirection {
        case .up:
            dismissedFrame.origin.y = -transitionContext.containerView.frame.size.height
        case .down:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        case .left:
            dismissedFrame.origin.x = -transitionContext.containerView.frame.size.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        }
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
