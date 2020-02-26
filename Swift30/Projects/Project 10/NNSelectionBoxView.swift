//
//  NNSelectionBoxView.swift
//  Swift30
//
//  Created by liupengkun on 2020/2/25.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

enum SelectionBoxBtnType: Int{
    case test1 = 0
    case test2
    case test3
    case test4
    case test5
}

protocol NNSelectionBoxBtnClickDelegate: class {
    func SelectionBtnClickWithType(selectionType: SelectionBoxBtnType)
}

class NNSelectionBoxView: UIView {
    
    lazy var backBigImgV: UIImageView = {
        let backBigImgV = UIImageView()
        backBigImgV.image = UIImage.init(named: "jiandingshaixuanbg")
        backBigImgV.isUserInteractionEnabled = true
        return backBigImgV
    }()
    
    weak var delegate: NNSelectionBoxBtnClickDelegate?
    var selectedBtn: UIButton = UIButton()
    let titleArr: [String] = ["测试1","测试2","测试3","测试4","测试5"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
        backBigImgV.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(self.backBigImgV)
        for i in 0..<titleArr.count {
            let btn: UIButton = UIButton.init(frame: CGRect(x: 0, y: CGFloat(i) * 31, width: 80, height: 30))
            btn.setTitle(titleArr[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.tag = 10 + i
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.addTarget(self, action: #selector(selectionBtnClick(sender:)), for: .touchUpInside)
            if i == 0{
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                selectedBtn = btn //默认选中
            }
            self.backBigImgV.addSubview(btn)
            if i < 4{
                let line: UIView = UIView.init(frame: CGRect(x: 5, y: CGFloat(i + 1) * 31, width: btn.frame.size.width - 10, height: 0.5))
                line.center.x = btn.center.x
                line.backgroundColor = UIColor.lightGray
                self.backBigImgV.addSubview(line)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configBtnUI(selectedType: SelectionBoxBtnType)  {
        selectedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let btn = self.viewWithTag(10 + selectedType.rawValue) as! UIButton
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        selectedBtn = btn
    }
    
    func showSelectionView(supV: UIView){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.layoutIfNeeded()
        }) { (success) in
            supV.addSubview(self)
        }
    }
    
    func hideSelectionView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { (success) in
            self.removeFromSuperview()
        }
    }
    
    @objc func selectionBtnClick(sender: UIButton) {
        selectedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        selectedBtn = sender
        
        switch sender.tag {
        case 10:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test1)
        case 11:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test2)
        case 12:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test3)
        case 13:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test4)
        case 14:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test5)
        default:
            self.delegate?.SelectionBtnClickWithType(selectionType: .test1)
        }
        hideSelectionView()
    }
}
