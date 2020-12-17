//
//  PostDetailViewController.swift
//  Reign Challenge
//
//  Created by Martin Regas on 20/10/2020.
//

import UIKit
import WebKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var webView:WKWebView!
    
    var viewModel: PostDetailViewModel!
    
    var spinner:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        self.title = viewModel.getTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPost()
    }
    
    func setViewModel(viewModel:PostDetailViewModel) {
        self.viewModel = viewModel
    }
    
    private func showPost() {
        if let strUrl = viewModel.post.url, let url = URL(string:strUrl) {
            self.spinner = self.displaySpinner(onView: self.view)
            let request = URLRequest(url: url)
            webView.load(request)
        }
        else {
            self.showError(error: "the webpage couldn't be loaded")
        }
    }
    
    func showError(error:String) {
        let alert = self.showAlertWith(message: error)
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: WKNavigationDelegate
extension PostDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        self.removeSpinner(spinner: self.spinner)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.removeSpinner(spinner: self.spinner)
        self.showError(error: "the webpage couldn't be loaded")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.removeSpinner(spinner: self.spinner)
        self.showError(error: "Timed out error")
    }
}
