//
//  NNReplyCommentView.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/29.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

protocol NNReplyCommentViewDelegate : NSObjectProtocol {
    func delegate_replacementText(text : String)
}

class NNReplyCommentView: UIView, UITextViewDelegate {

    weak var commentDelegate : NNReplyCommentViewDelegate?
    
    var isShow = false
    
    let space7: CGFloat = 7.0
    let space10: CGFloat = 10.0
    let space7Double: CGFloat = 14.0
    let textViewHeight: CGFloat = 36.0
    let totleHeight: CGFloat = 14.0+36.0
    
    static let sharedInstance: NNReplyCommentView = {
        let instance = NNReplyCommentView()
        return instance
    }()
    
    
    func showKeyboardType(type: UIKeyboardType, content: NSString) {
        if !isShow {
            self.show()
            textView.keyboardType = type
            placeHolderLabel.text = content.length > 0 ? content as String : ""
            textView.becomeFirstResponder()
        }
    }
    
    func show() {
        let window = UIApplication.shared.keyWindow
        self.frame = CGRect(x: 0, y: kScreenHeight, width: kScreen_width, height: 7*2+36)
        window?.addSubview(self)
    }
    
    func close() {
        isShow = false
        NotificationCenter.default.removeObserver(self)
        self.removeFromSuperview()
        self.endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configSubViews()
    }
    
    func configSubViews() {
        self.backgroundColor = UIColor.init(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        self.addSubview(lineView)
        self.addSubview(textView)
        textView.addSubview(placeHolderLabel)
        textView.setValue(placeHolderLabel, forKey: "_placeholderLabel")
        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        weak var weakSelf = self

        let userInfo = notification.userInfo! as NSDictionary
        let rect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let y = rect?.size.height
        let animationTime = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Float
        UIView.animate(withDuration: TimeInterval(animationTime)) {
            weakSelf?.frame = CGRect(x: 0, y: kScreenHeight-weakSelf!.totleHeight-y!, width: kScreen_width, height: weakSelf!.totleHeight)
            weakSelf?.textView.frame = CGRect(x: weakSelf!.space10, y: weakSelf!.space7, width: kScreen_width-weakSelf!.space10-weakSelf!.space10, height: weakSelf!.textViewHeight)
        }
        isShow = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        weak var weakSelf = self

        UIView.animate(withDuration: 0.25) {
            weakSelf!.textView.text = ""
            weakSelf!.textView.frame = CGRect(x: 10, y: 7, width: kScreen_width-10*2, height: 0)
            weakSelf?.frame = CGRect(x: 0, y: kScreenHeight+self.totleHeight, width: kScreen_width, height: 0)
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        isShow = false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let textString = textView.text.trimmingCharacters(in: CharacterSet.whitespaces)
            self.commentDelegate?.delegate_replacementText(text: textString)
            textView.resignFirstResponder()
        }
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let view : UITextView = object as! UITextView
        if keyPath == "contentSize" {
            var height = view.contentSize.height
            if height > 112 {
                height = 112
            }
            var textViewFrame = textView.frame
            textViewFrame.size.height = height
            textView.frame = textViewFrame
            self.updateSelfOfTextViewSize()
        }
    }
    
    func updateSelfOfTextViewSize()  {
        if textView.frame.size.height > 112 {
            return
        }
        
        weak var weakSelf = self

        UIView.animate(withDuration: 0.25) {
            var rect = self.frame
            rect.size.height = self.textView.frame.size.height+weakSelf!.space7Double
            let sourceY = rect.origin.y
            let disY = rect.size.height - self.frame.size.height
            rect.origin.y = sourceY - disY
            self.frame = rect
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lineView:UIView = {
        let lineView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreen_width, height: 0.5))
        lineView.backgroundColor = UIColor.init(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        return lineView
    }()
    
    lazy var textView:UITextView = {
        let textView = UITextView.init(frame: CGRect(x: 10, y: 7, width: kScreen_width-2*10, height: 36))
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 4
        textView.returnKeyType = UIReturnKeyType.send
        textView.font = UIFont.systemFont(ofSize: 16.0)
        textView.keyboardType = UIKeyboardType.default
        textView.delegate = self
        textView.inputAccessoryView = UIView.init()
        return textView
    }()
    
    lazy var placeHolderLabel:UILabel = {
        let placeHolderLabel = UILabel.init()
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = UIFont.systemFont(ofSize: 16.0)
        return placeHolderLabel
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        textView.removeObserver(self, forKeyPath: "contentSize")
    }
    
}
