//
//  NNBatteryController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/15.
//  Copyright © 2020 liupengkun. All rights reserved.
//

import UIKit

class NNBatteryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.navigationItem.title = "电池条"
        self.view.addSubview(battery)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.center = self.view.center
        label.text = "点我"
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        self.view.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let progressValue = arc4random() % +100
        UIView.animate(withDuration: 1) {
            var frame = self.battery.batteryView.frame
            frame.size.width = CGFloat(progressValue)*(self.battery.frame.size.width-self.battery.lineW*2)/100
            self.battery.batteryView.frame = frame
        }
    }
    

    // MARK: 懒加载电池条视图
    private lazy var battery: NNBatteryView = {
        let battery = NNBatteryView.init(frame: CGRect(x: 100, y: 100, width: 50, height: 25))
        return battery
    }()

}
