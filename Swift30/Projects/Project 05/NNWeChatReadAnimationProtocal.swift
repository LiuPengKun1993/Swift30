//
//  NNWeChatReadAnimationProtocal.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit


protocol NNWeChatReadAnimationProtocal {
    var tagertFrame:CGRect{set get}
    func transformAnimationView() -> Void
    var resertFrame:CGRect{set get}
    func closeAnimationView() -> Void
}

extension NNWeChatReadAnimationProtocal where Self:NNWeChatReadAnimationView {
    
    func transformAnimationView() -> Void {
        self.childView.isHidden = false
        self.isHidden = false
        weak var weakSelf = self
        UIView.animate(withDuration: 0.75, animations: {
            var form1 = CATransform3DIdentity
            form1.m34 = -1 / 900
            form1 = CATransform3DRotate(form1, CGFloat(-90 * Double.pi / 180), 0, 1, 0)
            weakSelf!.childView.layer.transform = form1
            weakSelf!.childView.frame = weakSelf!.tagertFrame
            weakSelf!.frame = weakSelf!.tagertFrame
        }, completion: { _ in
            weakSelf!.isUserInteractionEnabled = true
        })
    }
    
    func closeAnimationView() -> Void {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.75, animations: {
            var form1 = CATransform3DIdentity
            form1.m34 = -1 / 900
            form1 = CATransform3DRotate(form1, 0, 0, 1, 0)
            weakSelf!.childView.layer.transform = form1
            weakSelf!.childView.frame = CGRect(x: 0, y: 0, width: weakSelf!.resertFrame.size.width, height: weakSelf!.resertFrame.size.height)
            weakSelf!.frame = weakSelf!.resertFrame
        }, completion: { _ in
            weakSelf!.isUserInteractionEnabled = false
            weakSelf!.childView.isHidden = true
            weakSelf!.isHidden = true
        })
    }
}
