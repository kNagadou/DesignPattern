//
//  ViewController.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, DelegatePatternDelegate {
    
    var delegatePattern: DelegatePattern?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegatePattern = DelegatePattern()
        self.delegatePattern?.delegate = self
        
        setObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Singleton Pattern
    @IBAction func singletonPatternTUI(_ sender: UIButton) {
        inProgress()
        SingletonPattern.instance.doing(success: { [weak self] (response) in
            self?.progressSuccess(response: response!)
        }) { [weak self] (error) in
            self?.progressFailure(error: error!)
        }
    }
    
    // MARK: - Delegate Pattern
    @IBAction func delegatePatternTouchUpInside(_ sender: UIButton) {
        inProgress()
        delegatePattern?.doing()
    }

    // MARK: DelegatePatternDelegate Protocol
    func success(response: String) {
        progressSuccess(response: response)
    }
    
    func error(error: NSError) {
        progressFailure(error: error)
    }

    
    // MARK: - Closure Pattern
    @IBAction func closurePatternTouchUpInside(_ sender: UIButton) {
        inProgress()
        ClosurePattern.doing(success: { [weak self] (response) in
                self?.progressSuccess(response: response!)
            }, failure:{ [weak self] (error) in
                self?.progressFailure(error: error!)
        })
    }
    
    // MARK: - Observer Pattern
    @IBAction func observerPattern(_ sender: UIButton) {
        inProgress()
        ObserverPattern.doing()
    }
    
    func setObserver() {
        ObserverPattern.addObserver(observer: self,
                                    selector: #selector(self.receiveNotification(object:)),
                                    notification: ObserverPattern.Notification.success)
        ObserverPattern.addObserver(observer: self,
                                    selector: #selector(self.receiveNotification(object:)),
                                    notification: ObserverPattern.Notification.failure)
    }
    
    func receiveNotification(object: AnyObject?) {
        if let response: String = object?.object as? String {
            progressSuccess(response: response)
        } else if let error: NSError = object?.object as? NSError {
            progressFailure(error: error)
        }
    }
    func removeObserver() {
        ObserverPattern.removeObserver(observer: self, notification: ObserverPattern.Notification.success)
        ObserverPattern.removeObserver(observer: self, notification: ObserverPattern.Notification.failure)
    }
    
    func resetObserver() {
        removeObserver()
        setObserver()
    }
    
    // MARK: - ViewControllerの実装
    func showResult(_ result: String?) {
        if let text = result {
            messageLabel.text = text
        } else {
            messageLabel.text = "No Result"
        }
        resetObserver()
    }
    
    // 処理が成功
    func progressSuccess(response: String) {
        successMessage()
        showResult(response)
    }
    
    // 処理が失敗
    func progressFailure(error: NSError) {
        faliedMessage()
        showResult(error.description)
    }
    
    // MARK: SVProgressHUD
    func successMessage() {
        SVProgressHUD.showSuccess(withStatus: "成功")
    }
    
    func faliedMessage() {
        SVProgressHUD.showError(withStatus: "失敗")
    }
    
    func inProgress() {
        SVProgressHUD.showInfo(withStatus: "処理中")
    }
}

