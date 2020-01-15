//
//  NNStopWatchView.swift
//  Swift30
//
//  Created by 彭倩倩 on 2020/1/8.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

protocol NNStopWatchViewDelegate : NSObjectProtocol {
    // 开始/暂停按钮点击事件
    func delegate_playOrPauseAction(_ isSelected : Bool)
    // 重置点击事件
    func delegate_resetAction()
}

class NNStopWatchView: UIView {
    let timeLabel = UILabel()
    
    weak var delegate : NNStopWatchViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatChildViews()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatChildViews() {
        self.backgroundColor = UIColor.black
        addSubview(timeBtn)
        addSubview(resetBtn)
        addSubview(timeLabel)
        timeLabel.frame = CGRect.init(x: 0, y: kScreen_width/2.0, width: kScreen_width, height: kScreen_width/2.0)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.boldSystemFont(ofSize: 50)
        timeLabel.text = "0.0"
    }
    
    // MARK: 开始/暂停按钮点击事件
    @objc func timeBtnClick(button: UIButton) {
        // 防止连点
        button.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            button.isEnabled = true
        }
        if self.delegate != nil {
            self.delegate?.delegate_playOrPauseAction(button.isSelected)
            button.isSelected = !button.isSelected
        }
    }
    
    // MARK: 重置按钮点击事件
    @objc func resetBtnBtnClick() {
        timeBtn.isSelected = false
        if self.delegate != nil {
            self.delegate?.delegate_resetAction()
        }
    }
    
    // MARK: 懒加载开始/暂停按钮
    private lazy var timeBtn: UIButton = {
        let timeBtn = UIButton()
        timeBtn.frame = CGRect.init(x: 0, y: 0, width: kScreen_width/2.0, height: kScreen_width/2.0)
        timeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        timeBtn.setTitle("Play", for: .normal)
        timeBtn.backgroundColor = UIColor.blue
        timeBtn.setTitle("Pause", for: .selected)
        timeBtn.setTitleColor(UIColor.white, for: .normal)
        timeBtn.setTitleColor(UIColor.black, for: .selected)
        timeBtn.addTarget(self, action: #selector(timeBtnClick), for: .touchUpInside)
        return timeBtn
    }()
    
    // MARK: 懒加载重置按钮
    private lazy var resetBtn: UIButton = {
        let resetBtn = UIButton()
        resetBtn.frame = CGRect.init(x: kScreen_width/2.0, y: 0, width: kScreen_width/2.0, height: kScreen_width/2.0)
        resetBtn.backgroundColor = UIColor.cyan
        resetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.setTitleColor(UIColor.white, for: .normal)
        resetBtn.addTarget(self, action: #selector(resetBtnBtnClick), for: .touchUpInside)
        return resetBtn
    }()
}
