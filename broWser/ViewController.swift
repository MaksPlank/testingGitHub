
//
//  ViewController.swift
//  broWser
//
//  Created by Maks Plank on 12.08.2020.
//  Copyright © 2020 Natalia Golovko. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var searchOutlet: UIBarButtonItem!
    @IBOutlet weak var backOutlet: UIBarButtonItem!
    @IBOutlet weak var window: WKWebView!
    
    let link = "https://google.com"
    
    
    
    //MARK: - View -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // назначение данного класса VC делегатом TextField (UITextFieldDelegate)
        textFieldOutlet.delegate = self
        
        // назначение данного класса VC делегатом WebView (WKNavigationDelegate)
        window.navigationDelegate = self
        
        // set WebKit
        window.load(URLRequest(url: URL(string: link)!))
        window.allowsBackForwardNavigationGestures = true
        
        // TF navigation
        textFieldOutlet.text = link
        }
    
    
    //MARK: - Описание кнопок: Back/Forward -
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        
        // если кнопка включена - проверяем возможность перехода вперед:
        if window.canGoForward {
            window.goForward()
            }
        }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        // если кнопка включена - проверяем возможность вернуться назад:
        if window.canGoBack {
            window.goBack()
            }
        }
    
    
}




extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    
    //MARK: - Метод для передачи данных из TF в браузер -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // введенные в TF данных кладем в константу (-> String)
        // let urlString = textFieldOutlet.text!
        
        let request = URLRequest(url: URL(string: textFieldOutlet.text!)!)
        window.load(request)
        
        // переход по ссылке введенной в TF
        textFieldOutlet.resignFirstResponder()
        
        return true
        }
    
    
    
    //MARK: - Метод для записи верного url в адресную строку -
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // переносим строку адреса в текстовое поле
        textFieldOutlet.text = window.url?.absoluteString
        
        // возможность включения кнопок Back/Searck
        backOutlet.isEnabled = webView.canGoBack
        searchOutlet.isEnabled = webView.canGoForward
        }
}
