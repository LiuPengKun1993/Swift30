//
//  ViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/8.
//  Copyright © 2020 liupengkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var classNames = ["NNStopWatchController", "NNBatteryController", "NNValidationCodeController", "NNValidationController"]
    var titleNames = ["计时器", "电池条", "圆形验证码输入框", "图形验证码"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(baseView)
    }
    
    // MARK: cell 个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    // MARK: cell 内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        cell?.selectionStyle = UITableViewCell.SelectionStyle.gray
        cell?.textLabel?.text = titleNames[indexPath.row]
        return cell!
    }
    
    // MARK: cell 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let class_VC = NSClassFromString("Swift30.\(classNames[indexPath.row])") as! UIViewController.Type
        let vc = class_VC.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: 懒加载列表视图
    private lazy var baseView: UITableView = {
        let baseView = UITableView()
        baseView.frame = CGRect(x: 0, y: 0, width: kScreen_width, height: kScreenHeight)
        baseView.tableFooterView = UIView()
        baseView.delegate = self as UITableViewDelegate
        baseView.dataSource = self as UITableViewDataSource
        return baseView
    }()
}
