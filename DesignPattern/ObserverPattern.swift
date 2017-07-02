//
//  ObserverPattern.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

protocol Notifier {
    associatedtype Notification: RawRepresentable
}

extension Notifier where Notification.RawValue == String {
    
    fileprivate static func nameFor(notification: Notification) -> String {
        return "\(notification.rawValue)"
    }
    
    /** Wrapper NotificationCenter addObserver */
    static func addObserver(observer: AnyObject, selector: Selector, notification: Notification) {
        let notificationName = nameFor(notification: notification)
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: NSNotification.Name(rawValue: notificationName),
                                               object: nil)
    }
    
    /** Wrapper NotificationCenter post */
    static func postNotification(notification: Notification,
                                 object: AnyObject? = nil,
                                 userInfo: [String: Any]? = nil) {
        let notificationName = nameFor(notification: notification)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName),
                                        object: object,
                                        userInfo: userInfo)
    }
    
    /** Wrapper NotificationCenter removeObserver */
    static func removeObserver(observer: AnyObject,
                               notification: Notification,
                               object: AnyObject? = nil) {
        let notificationName = nameFor(notification: notification)
        NotificationCenter.default.removeObserver(observer,
                                                  name: NSNotification.Name(rawValue: notificationName),
                                                  object: object)
    }
}

class ObserverPattern: Notifier {
    
    enum Notification: String {
        case success
        case failure
    }
    
    static func doing() {
        Stub_ServerConnection.get(success: { (response) in
            print(response)
            let res = response.appending("Observer Pattern で実行しました")
            ObserverPattern.postNotification(notification: Notification.success, object: res as AnyObject?, userInfo: nil)
        }) { (error) in
            print(error)
            ObserverPattern.postNotification(notification: Notification.failure, object: error as AnyObject?, userInfo: nil)
        }
    }
    
}
