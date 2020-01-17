//
//  NNWebViewController.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/17.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit
import WebKit

class NNWebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        self.view.addSubview(progressView)
        setupToolView()
    }
    
    func setupToolView() {
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: kNavigationHeight, width: kScreen_width, height: 40))
        self.view.addSubview(toolBar)
        let fixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let backButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(goBackAction))
        let refreshButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(refreshAction))
        let forwardButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(goForwardAction))
        toolBar.setItems([backButton, fixedSpace, refreshButton,fixedSpace, forwardButton], animated: true)
        
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        rightButton.setTitle("原生调JS", for: UIControl.State.normal)
        rightButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: UIControl.Event.touchUpInside)
        let item = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item
    }
    
    // MARK: 点击事件区域
    @objc func goBackAction() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func refreshAction() {
        webView.reload()
    }
    
    @objc func goForwardAction() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func rightButtonClick() {
        let customText = "原生调JS, "
        let labelId = "labelId"
        let jsString = "changeTextContent('\(labelId)', '\(customText)')"
        webView.evaluateJavaScript(jsString) { (data, error) in
            
        }
    }
    
    // MARK: 代理区域
    // 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.5);
        view.bringSubviewToFront(progressView)
    }
    
    // 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    // 加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let parameter:NSDictionary = message.body as! NSDictionary
        if message.name == "jsCallNativeNoPrams" {
            let alertController = UIAlertController.init(title: "JS调原生", message: nil, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction.init(title: "知道了", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if message.name == "jsCallNativeWithPrams" {
            let alertController = UIAlertController.init(title: "JS调原生", message: (parameter.value(forKey: "params") as! String), preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction.init(title: "知道了", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1 {
                weak var weakSelf = self
                UIView.animate(withDuration: 0.25, animations: {
                    weakSelf!.progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.4)
                }, completion: { _ in
                    weakSelf!.progressView.isHidden = true
                })
            }
        } else if keyPath == "title" {
            navigationItem.title = webView.title
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // MARK: 懒加载区域
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView.init(frame: CGRect(x: 0, y: kNavigationHeight, width: kScreen_width, height: 2))
        progressView.tintColor = UIColor.blue
        progressView.trackTintColor = UIColor.white
        return progressView
    }()
    
    lazy var webView : WKWebView =  {
        // 网页配置
        let configuration = WKWebViewConfiguration.init()
        let userContentController = WKUserContentController.init()
        userContentController.add(self, name: "jsCallNativeNoPrams")
        userContentController.add(self, name: "jsCallNativeWithPrams")
        configuration.userContentController = userContentController
        
        // 注入脚本
        let jsString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"

        let wkScript = WKUserScript.init(source: jsString, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(wkScript)
        
        let webView = WKWebView.init(frame: CGRect(x: 0, y: kNavigationHeight+40, width: kScreen_width, height: kSafeAreaHeight-40), configuration: configuration)
        let path = Bundle.main.path(forResource: "Native&JS.html", ofType: nil)
        var urlStr = NSURL.fileURL(withPath: path!);
        webView.load(NSURLRequest(url:urlStr) as URLRequest);

        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.isMultipleTouchEnabled = true
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        
        return webView
    }()
    
    // MARK: 移除各种监听
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "jsCallNativeNoPrams")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "jsCallNativeWithPrams")

    }
    
}
