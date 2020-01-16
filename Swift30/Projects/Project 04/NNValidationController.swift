//
//  NNValidationController.swift
//  Swift30
//
//  Created by 彭倩倩 on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNValidationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(validation)
        self.navigationItem.title = "图形验证码"
        // Do any additional setup after loading the view.
    }
    

    // MARK: 懒加载图形验证码
    private lazy var validation: NNValidationView = {
        let validation = NNValidationView.init(frame: CGRect(x: 60, y: 200, width: 200, height: 40))
        validation.center = CGPoint(x: kScreen_width/2, y: 200)
        return validation
    }()

}
