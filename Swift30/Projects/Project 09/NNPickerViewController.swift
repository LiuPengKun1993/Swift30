//
//  NNPickerViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/2/4.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNPickerViewController: UIViewController, NNPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "选择器"
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.center = self.view.center
        label.text = "点我"
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.red
        self.view.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pickerView = NNPickerView.init()
        pickerView.pickDelegate = self
        pickerView.dataSource = dataSource
        // 默认首次滑到索引为10行
        pickerView.setSelectIndex(index: 10)
    }
    
    func delegate_selectString(text: String, index: NSInteger) {
        print("字符：\(text), 索引：\(index)")
    }
    
    
    lazy var dataSource:NSArray = {
        var dataSource: [String] = []
        for index in 1...30 {
            let string = "元素 \(index)"
            dataSource.append(string)
        }
        return dataSource as NSArray
    }()

}
