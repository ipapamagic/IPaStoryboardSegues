//
//  IPaSlideInPresentationController.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit


class IPaSlideInPresentationController: UIPresentationController {
    var slideInInfo:IPaSlideInInfo!
    /// black layer
    lazy var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onClose(_:)))
        view.addGestureRecognizer(gesture)
        view.alpha = 0

        return view
    }()
    /// define the frame
    public override var frameOfPresentedViewInContainerView: CGRect {
        var rect = CGRect(origin: .zero, size: self.slideInInfo.contentSize)
        switch self.slideInInfo.slideDirection {
        case .up:
            rect.origin.y = 0
            rect.origin.x = (UIScreen.main.bounds.width - self.slideInInfo.contentSize.width) * 0.5
        case .down:
            rect.origin.y = UIScreen.main.bounds.height - self.slideInInfo.contentSize.height
            rect.origin.x = (UIScreen.main.bounds.width - self.slideInInfo.contentSize.width) * 0.5
        case .left:
            rect.origin.x = 0
            rect.origin.y = (UIScreen.main.bounds.height - self.slideInInfo.contentSize.height) * 0.5
        case .right:
            rect.origin.x = UIScreen.main.bounds.height - self.slideInInfo.contentSize.height
            rect.origin.y = (UIScreen.main.bounds.height - self.slideInInfo.contentSize.height) * 0.5
        }
        return rect
    }
    public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?,slideDelegate:IPaSlideInInfo) {
        //get height from an objec of PresentBottomVC class
        self.slideInInfo = slideDelegate
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    
    /// add blackView to the container and let alpha animate to 1 when show transition will begin
    public override func presentationTransitionWillBegin() {
        containerView?.insertSubview(blackView, at: 0)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": blackView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": blackView]))
        
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            blackView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.blackView.alpha = 1.0
        })
    }
    
    /// let blackView's alpha animate to 0 when hide transition will begin.
    public override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            blackView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.blackView.alpha = 0.0
        })
    }
    
    /// remove the blackView when hide transition end
    ///
    /// - Parameter completed: completed or no
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    
    
    @objc func onClose(_ sender:Any) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
}
