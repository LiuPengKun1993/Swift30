//
//  NNWeChatReadAnimationView.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNWeChatReadAnimationView: UIView, NNWeChatReadAnimationProtocal {
    

    var childView:UIView!
    var tagertFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var resertFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        childView = UIView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        childView.backgroundColor = UIColor.darkGray
        self.addSubview(childView)
        self.sendSubviewToBack(childView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
