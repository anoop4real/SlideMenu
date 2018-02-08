//
//  WebViewController.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 06/02/18.
//  Copyright © 2018 anoop. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {

    private var genericWebView: WKWebView!
    private var webUrl: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpWKWebView()
        load(url: webUrl)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpWebControllerWith(url: String) {
        webUrl = url
    }
    // MARK: Setup
    private func setUpWKWebView() {
        genericWebView = WKWebView(frame: self.view.bounds)
        genericWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        genericWebView.navigationDelegate = self
        self.view.addSubview(genericWebView)
    }

    private func load(url: String) {

        guard let request = url.asURLRequest() else { return  }
        genericWebView.load(request)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WebViewController: WKNavigationDelegate {

    // MARK: Navigation Delegates
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {

        guard let requestUrl = navigationAction.request.url?.absoluteString else {
            decisionHandler(.cancel)
            return
        }
        switch navigationAction.navigationType {
        case .linkActivated:
            UIApplication.shared.openURL(URL(string: requestUrl)!)
        default:
            break
        }
        decisionHandler(.allow)
    }

}
