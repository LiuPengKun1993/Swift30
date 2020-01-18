//
//  NNTextView.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/18.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

protocol NNTextViewDelegate : NSObjectProtocol {
    func delegate_textValueDidChanged(textViewHeight : CGFloat)
}

class NNTextView: UITextView {
    
    var placeholderText: String? {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    
    var placeholderColor: UIColor? {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    var maxNumberOfLines: NSInteger? {
        didSet {
            if (self.font?.lineHeight) == nil {
                self.font = UIFont.systemFont(ofSize: 17)
            }
            placeholderLabel.text = "自动换行到第 \(maxNumberOfLines ?? 3) 行"
            maxTextHeight = ceil(self.font!.lineHeight * CGFloat(Float(maxNumberOfLines!)) + self.textContainerInset.top + self.textContainerInset.bottom)
        }
    }
    
    weak var customDelegate : NNTextViewDelegate?
    
    
    // 文字高度
    private var currentTextHeight:CGFloat = 0.0
    // 文字原始高度
    private var originTextHeight:CGFloat = 0.0
    // 文字最大高度
    private var maxTextHeight:CGFloat = 0.0
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        maxNumberOfLines = 3
        self.isScrollEnabled = false
        self.scrollsToTop = false
        self.showsHorizontalScrollIndicator = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        originTextHeight = self.bounds.size.height
        NotificationCenter.default.addObserver(self, selector: #selector(textValueDidChange), name: UITextView.textDidChangeNotification, object: self)
        self.addSubview(placeholderLabel)
        //        self.setValue(placeholderLabel, forKey: "_placeholderLabel")
    }
    
    @objc func textValueDidChange() {
        placeholderLabel.isHidden = self.text.count > 0 ? true : false
        let tempHeight = ceil(self.sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))).height)
        if currentTextHeight != tempHeight && tempHeight > originTextHeight {
            self.isScrollEnabled = (tempHeight > maxTextHeight && maxTextHeight > 0) ? true : false
            currentTextHeight = tempHeight
            if (customDelegate != nil) && isScrollEnabled == false {
                customDelegate?.delegate_textValueDidChanged(textViewHeight: tempHeight)
            }
        }
    }
    
    
    lazy var placeholderLabel:UITextView = {
        let placeholderLabel = UITextView.init(frame: self.bounds)
        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.text = "自动换行到第 \(maxNumberOfLines ?? 3) 行"
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.font = self.font;
        placeholderLabel.textColor = UIColor.lightGray
        return placeholderLabel
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

