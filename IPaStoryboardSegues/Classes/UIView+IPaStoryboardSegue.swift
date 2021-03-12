//
//  UIView+IPaStoryboardSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2020/12/7.
//

import UIKit

extension UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    open func addSubView(_ view:UIView,with edgeInsets:UIEdgeInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: edgeInsets.right).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edgeInsets.bottom).isActive = true
    }
    open func addSubViewToFill(_ view:UIView) {
        self.addSubView(view,with: .zero)
    }
}
extension UIViewController {
    open func easyRemoveFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    open func easyAddChild(_ viewController:UIViewController,addSubView:((UIView)->())?) {
        self.addChild(viewController)
        if let addSubView = addSubView {
            addSubView(viewController.view)
        }
        else {
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubViewToFill(viewController.view)
        }
        viewController.willMove(toParent: self)
    }
}
