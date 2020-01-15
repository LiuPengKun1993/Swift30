//
//  NNStopWatchController.swift
//  Swift30
//
//  Created by 彭倩倩 on 2020/1/8.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNStopWatchController: UIViewController, NNStopWatchViewDelegate {
    var timer: Timer? = Timer()
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        self.navigationItem.title = "计时器"
        self.view.addSubview(baseView)
        counter = 0.0
    }
    
    var counter: Float = 0.0 {
        didSet {
            baseView.timeLabel.text = String(format: "%.1f", counter)
        }
    }
    
    // MARK: 开始/暂停按钮点击事件
    func delegate_playOrPauseAction(_ isSelected : Bool) {
        if (isSelected) {
            if let timerTemp = timer {
                timerTemp.invalidate()
            }
            timer = nil
            isPlaying = false
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
    }
    
    // MARK: 重置点击事件
    func delegate_resetAction() {
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        counter = 0
    }
    
    // MARK: 懒加载列表视图
    private lazy var baseView: NNStopWatchView = {
        let baseView = NNStopWatchView()
        baseView.frame = CGRect.init(x: 0, y: 0, width: kScreen_width, height: kScreen_width)
        baseView.center = self.view.center
        baseView.delegate = self
        return baseView
    }()
}
