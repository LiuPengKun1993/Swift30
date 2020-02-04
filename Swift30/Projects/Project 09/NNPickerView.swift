//
//  NNPickerView.swift
//  Swift30
//
//  Created by liupengkun on 2020/2/4.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

protocol NNPickerViewDelegate : NSObjectProtocol {
    func delegate_selectString(text : String, index: NSInteger)
}

class NNPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var pickDelegate : NNPickerViewDelegate?

    let bgViewHeigth: CGFloat = 240
    let cityPickViewHeigh: CGFloat = 200
    let toolsViewHeith: CGFloat = 40
    let animationTime: CGFloat = 0.25;
    var selectString = ""
    var index = 0
    var dataArr = ["test1", "test2", "test3"]
    var dataSource : NSArray? {
        didSet {
            self.dataArr = dataSource as! [String]
            self.pickerView.layoutSubviews()
            self.pickerView.reloadAllComponents()
            selectString = dataArr[index]
            selectLalel.text = selectString
        }
    }
    
    // MARK: - 暴露的方法，第一次选中哪个
    func setSelectIndex(index: NSInteger) {
        pickerView.selectRow(index, inComponent: 0, animated: true)
        selectLalel.text = dataArr[index]
        selectString = dataArr[index]
        self.index = index
    }

    // MARK: - 初始化区域
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    func initSubViews() {
        let windowView = UIApplication.shared.delegate?.window
        self.frame = UIApplication.shared.keyWindow!.bounds
        windowView?!.addSubview(self)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(bgView)
        bgView.addSubview(toolsView)
        toolsView.addSubview(canselButton)
        toolsView.addSubview(sureButton)
        toolsView.addSubview(selectLalel)
        bgView.addSubview(pickerView)
        pickerView.selectRow(0, inComponent: 0, animated: false)
        selectString = dataArr[0]
        selectLalel.text = selectString
        index = 0
        showPickView()
    }
    
    // MARK: - 代理区域
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.text = dataArr[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dataArr.count == 0 {
            return
        }
        
        selectString = dataArr[row]
        selectLalel.text = selectString
        index = row
    }
    
    // MARK: - 事件区域
    @objc func canselButtonClick() {
        weak var weakSelf = self
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            weakSelf!.bgView.frame = CGRect(x: 0, y: weakSelf!.frame.size.height, width: weakSelf!.frame.size.width, height: weakSelf!.bgViewHeigth)
        }, completion: { _ in
            weakSelf!.removeFromSuperview()
        })
    }
    
    @objc func sureButtonClick() {
        if selectString.count == 0 {
            return
        }
        
        self.canselButtonClick()
        self.pickDelegate?.delegate_selectString(text: selectString, index: index)
    }
    
    func showPickView() {
        weak var weakSelf = self
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            weakSelf!.bgView.frame = CGRect(x: 0, y: weakSelf!.frame.size.height - weakSelf!.bgViewHeigth, width: weakSelf!.frame.size.width, height: weakSelf!.bgViewHeigth)
        }, completion: { _ in
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载区域
    lazy var bgView:UIView = {
        let bgView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: bgViewHeigth))
        bgView.backgroundColor = UIColor.white
        return bgView
    }()
    
    lazy var pickerView:UIPickerView = {
        let pickerView = UIPickerView.init(frame: CGRect(x: 0, y: toolsViewHeith, width: self.frame.size.width, height: cityPickViewHeigh))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var toolsView:UIView = {
        let toolsView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: toolsViewHeith))
        toolsView.layer.borderWidth = 0.5
        toolsView.layer.borderColor = UIColor.gray.cgColor
        return toolsView
    }()
    
    lazy var canselButton:UIButton = {
        let canselButton = UIButton.init(type: UIButton.ButtonType.custom)
        canselButton.frame = CGRect(x: 20, y: 0, width: 50, height: toolsViewHeith)
        canselButton.setTitle("取消", for: UIControl.State.normal)
        canselButton.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        canselButton.addTarget(self, action: #selector(canselButtonClick), for: UIControl.Event.touchUpInside)
        return canselButton
    }()
    
    lazy var sureButton:UIButton = {
        let sureButton = UIButton.init(type: UIButton.ButtonType.custom)
        sureButton.frame = CGRect(x: self.frame.size.width - 20 - 50, y: 0, width: 50, height: toolsViewHeith)
        sureButton.setTitle("确定", for: UIControl.State.normal)
        sureButton.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        sureButton.addTarget(self, action: #selector(sureButtonClick), for: UIControl.Event.touchUpInside)
        return sureButton
    }()
    
    lazy var selectLalel:UILabel = {
        let selectLalel = UILabel.init(frame: CGRect(x: (self.frame.size.width-100) / 2, y: 0, width: 100, height: toolsViewHeith))
        selectLalel.text = "请选择"
        selectLalel.font = UIFont.systemFont(ofSize: 14)
        selectLalel.textAlignment = NSTextAlignment.center
        return selectLalel
    }()
}
