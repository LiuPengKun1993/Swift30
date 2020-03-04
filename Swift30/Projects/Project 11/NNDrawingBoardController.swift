//
//  NNDrawingBoardController.swift
//  Swift30
//
//  Created by 彭倩倩 on 2020/3/4.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNDrawingBoardController: UIViewController {

    @IBOutlet weak var boardView: NNDrawingBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "画板"
        let item1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(saveBoardImage))
        let items2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(clearDrawBoard))
        self.navigationItem.rightBarButtonItems = [item1, items2]
    }
    
    @objc func saveBoardImage() {
        let image = boardView.getImage()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(finishSaveAlert(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func finishSaveAlert(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "保存失败", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好吧", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "保存成功", message: "该作品已保存到你的相册", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func clearDrawBoard() {
        boardView.clearBoard()
    }

    @IBAction func clicked(_ sender: UIButton) {
        boardView.pathColor = sender.backgroundColor!
    }
}
