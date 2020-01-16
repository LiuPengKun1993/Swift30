//
//  NNValidationCodeController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNValidationCodeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "圆形验证码输入框"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(validationCode)
    }
    
    // MARK: 懒加载圆形验证码输入框
    private lazy var validationCode: NNValidationCodeView = {
        let validationCode = NNValidationCodeView.init(frame: CGRect(x: 60, y: 200, width: 300, height: 40))
        validationCode.center = CGPoint(x: kScreen_width/2, y: 200)
        validationCode.defaultColor = UIColor.black
        validationCode.changedColor = UIColor.red
        return validationCode
    }()

}
