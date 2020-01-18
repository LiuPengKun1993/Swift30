//
//  NNTextViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/18.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNTextViewController: UIViewController, NNTextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TextView封装"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(textView)
    }
    
    func delegate_textValueDidChanged(textViewHeight: CGFloat) {
        var frame = textView.frame;
        frame.size.height = textViewHeight;
        textView.frame = frame;
    }
    
    lazy var textView:NNTextView = {
        let textView = NNTextView.init(frame: CGRect(x: 10, y: 100, width: self.view.frame.size.width-20, height: 50))
        textView.customDelegate = self
        textView.maxNumberOfLines = 5
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
}
