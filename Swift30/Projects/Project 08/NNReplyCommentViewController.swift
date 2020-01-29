//
//  NNReplyCommentViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/29.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNReplyCommentViewController: UIViewController, NNReplyCommentViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "高度自适应的评论框"
        self.view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "评论", style: UIBarButtonItem.Style.plain, target: self, action: #selector(replyViewAppear))
    }
    
    @objc func replyViewAppear() {
        if replyView.isShow {
            return
        }
        
        replyView.showKeyboardType(type: UIKeyboardType.default, content: "评论")
        replyView.commentDelegate = self
    }
    
    func delegate_replacementText(text: String) {
        print(text)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if replyView.isShow {
            replyView.close()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        replyView.endEditing(true)
        self.view.endEditing(true)
    }
    

    lazy var replyView: NNReplyCommentView = {
        let replyView = NNReplyCommentView.init()
        return replyView
    }()

}
