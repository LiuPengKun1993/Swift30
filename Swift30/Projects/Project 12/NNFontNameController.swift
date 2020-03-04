//
//  NNFontNameController.swift
//  Swift30
//
//  Created by liupengkun on 2020/3/4.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNFontNameController: UIViewController,UITableViewDataSource,UITableViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Font Names"
        view.addSubview(baseView)
    }
    
    // MARK: cell 个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    // MARK: cell 内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        cell?.selectionStyle = UITableViewCell.SelectionStyle.gray
        let name = UIFont.familyNames[indexPath.row]
        cell?.textLabel?.text = "hello Swift"
        cell?.detailTextLabel?.text = name
        cell?.textLabel?.font = UIFont(name: name, size: 20)
        return cell!
    }
    
    // MARK: cell 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
