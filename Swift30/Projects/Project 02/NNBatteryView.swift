//
//  NNBatteryView.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/15.
//  Copyright © 2020 liupengkun. All rights reserved.
//

import UIKit

class NNBatteryView: UIView {

    var batteryView = UIView()
    var lineW = CGFloat()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatChildViews()
    }
    
    func creatChildViews() {
        // 电池条宽度
        let w = self.bounds.size.width
        // 电池条高度
        let h = self.bounds.size.height
        // 电池条x坐标
        let x = self.bounds.origin.x
        // 电池条y坐标
        let y = self.bounds.origin.y
        
        // 电池条线宽
        lineW = 1
        // 绘制电池条
        let path1 = UIBezierPath.init(roundedRect: CGRect(x: x, y: y, width: w, height: h), cornerRadius: 2)
        let batteryLayer = CAShapeLayer.init(layer: layer)
        batteryLayer.lineWidth = lineW
        batteryLayer.strokeColor = UIColor.white.cgColor
        batteryLayer.fillColor = UIColor.clear.cgColor
        batteryLayer.path = path1.cgPath
        self.layer.addSublayer(batteryLayer)
        
        let path2 = UIBezierPath.init()
        path2.move(to: CGPoint(x: x+w+1, y: y+h/3))
        path2.addLine(to: CGPoint(x: x+w+1, y: y+h*2/3))
        let batteryLayer2 = CAShapeLayer.init(layer: layer)
        batteryLayer2.lineWidth = 2
        batteryLayer2.strokeColor = UIColor.white.cgColor
        batteryLayer2.fillColor = UIColor.clear.cgColor
        batteryLayer2.path = path2.cgPath
        self.layer.addSublayer(batteryLayer2)
        
        // 电池条进度
        self.batteryView = UIView.init(frame: CGRect(x: x+1, y: y+self.lineW, width: 0, height: h-self.lineW*2))
        self.batteryView.layer.cornerRadius = 2
        self.batteryView.backgroundColor = UIColor.white
        self.addSubview(self.batteryView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
