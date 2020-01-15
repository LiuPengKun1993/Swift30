//
//  swift30.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/8.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

/** 导航栏的高 44 */
let kNavigationBarHeight = CGFloat(44)

/** *屏幕高*/
let kScreenHeight = UIScreen.main.bounds.size.height
/** *屏幕宽*/
let kScreen_width = UIScreen.main.bounds.size.width

let kStatusBarHeight = UIApplication.shared.statusBarFrame.height

/* 底部安全区 区 */
let kBottomHomeHeight = CGFloat(kStatusBarHeight > 20.0 ? 34.0 : 0.0)

/*! 安全区，屏高 - home 区 - 导航 - 状态栏 */
let kSafeAreaHeight = (kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kBottomHomeHeight)
