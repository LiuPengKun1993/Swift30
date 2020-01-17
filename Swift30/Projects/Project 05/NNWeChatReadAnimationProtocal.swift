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
        UIView.animate(withDuration: 0.75, animations: {
            var form1 = CATransform3DIdentity
            form1.m34 = -1 / 900
            form1 = CATransform3DRotate(form1, CGFloat(-90 * Double.pi / 180), 0, 1, 0)
            self.childView.layer.transform = form1
            self.childView.frame = self.tagertFrame
            self.frame = self.tagertFrame
        }, completion: { _ in
            self.isUserInteractionEnabled = true
        })
    }
    
    func closeAnimationView() -> Void {
        UIView.animate(withDuration: 0.75, animations: {
            var form1 = CATransform3DIdentity
            form1.m34 = -1 / 900
            form1 = CATransform3DRotate(form1, 0, 0, 1, 0)
            self.childView.layer.transform = form1
            self.childView.frame = CGRect(x: 0, y: 0, width: self.resertFrame.size.width, height: self.resertFrame.size.height)
            self.frame = self.resertFrame
        }, completion: { _ in
            self.isUserInteractionEnabled = false
            self.childView.isHidden = true
            self.isHidden = true
        })
    }
}
