//
//  NNSelectionBoxViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/2/25.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNSelectionBoxViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择框"
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(selectBtn)
    }
    
    // MARK: - 自定义事件区域
    @objc func selectBtnClick(){
        let rect2 = selectBtn.frame
        self.selectionBoxV.frame = CGRect(x: rect2.origin.x+10, y: rect2.origin.y + 20, width: 80, height: self.selectionBoxV.frame.size.height)
        self.selectionBoxV.showSelectionView(supV: self.view)
    }
    
    func updateTopSelectBtnWidth(titleStr: String){
        selectBtn.setTitle(titleStr, for: .normal)
    }
    
    // MARK: - 懒加载区域
    lazy var selectBtn: UIButton = {
        let selectBtn = UIButton.init(type: .custom)
        selectBtn.frame = CGRect(x: kScreen_width-100, y: 200, width: 100, height: 20)
        selectBtn.setTitle("选择框", for: .normal)
        selectBtn.setTitleColor(UIColor.black, for: .normal)
        selectBtn.titleLabel?.textAlignment = .right
        selectBtn.addTarget(self, action: #selector(selectBtnClick), for: .touchUpInside)
        return selectBtn
    }()
    
    lazy var selectionBoxV: NNSelectionBoxView = {
        let selectionBoxV = NNSelectionBoxView.init(frame: CGRect(x:  selectBtn.frame.origin.x + 10, y:  selectBtn.frame.origin.y + 20, width: 80, height: 154))
        selectionBoxV.delegate = self
        selectionBoxV.alpha = 0
        return selectionBoxV
    }()
}

// MARK: - NNSelectionBoxBtnClickDelegate
extension NNSelectionBoxViewController: NNSelectionBoxBtnClickDelegate {
    func SelectionBtnClickWithType(selectionType: SelectionBoxBtnType) {
        print(selectionType.rawValue)
        switch selectionType {
        case .test1:
            selectBtn.setTitle(selectionBoxV.titleArr[0], for: .normal)
        case .test2:
            selectBtn.setTitle(selectionBoxV.titleArr[1], for: .normal)
        case .test3:
            selectBtn.setTitle(selectionBoxV.titleArr[2], for: .normal)
        case .test4:
            selectBtn.setTitle(selectionBoxV.titleArr[3], for: .normal)
        case .test5:
            selectBtn.setTitle(selectionBoxV.titleArr[4], for: .normal)
        }
    }
}

