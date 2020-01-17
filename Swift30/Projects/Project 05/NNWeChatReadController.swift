//
//  NNWeChatReadController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNWeChatReadController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let cellID = "CollectionViewCell"
    var tempFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "微信读书翻页"
        self.view.addSubview(collectionView)
        self.view.addSubview(animationView)
    }
    
    // MARK:collectionView 代理区域
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = collectionView.cellForItem(at: indexPath)
        tempFrame = item!.convert(item!.bounds, to: self.view)
        animationView.frame = tempFrame
        animationView.childView.frame = CGRect(x: 0, y: 0, width: tempFrame.width, height: tempFrame.height)

        animationView.tagertFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        animationView.transformAnimationView()
    }
    
    // MARK animationView 放大后的点击事件
    @objc func animationViewAction() {
        animationView.resertFrame = tempFrame
        animationView.closeAnimationView()
    }
    
    // MARK: 懒加载 collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    // MARK: 懒加载 animationView
    lazy var animationView: NNWeChatReadAnimationView = {
        let animationView = NNWeChatReadAnimationView.init()
        animationView.backgroundColor = UIColor.lightGray
        animationView.childView.layer.anchorPoint =  CGPoint(x: 0, y: 0.5)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(animationViewAction))
        animationView.addGestureRecognizer(gesture)
        return animationView
    }()
    
}
