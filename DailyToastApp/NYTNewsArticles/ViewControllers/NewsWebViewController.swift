//
//  NewsWebViewController.swift
//  DailyToastApp
//
//  Created by jothi on 07/08/23.
//

import Foundation
import WebKit


class NewsWebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var webUrlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)

        if let url = URL(string: webUrlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
