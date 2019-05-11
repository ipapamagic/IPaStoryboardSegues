//
//  IPaReplaceRootSegue.swift
//  Pods
//
//  Created by IPa Chen on 2017/5/2.
//
//

import UIKit

open class IPaReplaceRootSegue: UIStoryboardSegue {
    override open func perform() {
        guard let oWindow = UIApplication.shared.delegate?.window else {
            return
        }
        let window = oWindow!
        guard let oldVC = window.rootViewController else {
            window.rootViewController = self.destination
            return;
        }
        let snapshot = oldVC.view!
        snapshot.snapshotView(afterScreenUpdates: true)
        self.destination.view.addSubview(snapshot)
        window.rootViewController = self.destination
        
        UIView.animate(withDuration: 0.5, animations: {
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            finished in
            snapshot.removeFromSuperview()
        })
    }
}
