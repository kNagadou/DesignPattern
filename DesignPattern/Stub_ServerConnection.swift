//
//  Stub_ServerConnection.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

class Stub_ServerConnection: NSObject {

    static func get(success: @escaping (_ response: String) -> Void, failure: @escaping (_ :NSError) -> Void) {
        Thread.sleepAsync(forTimeInterval: 0.5, completion: {
            if (Bool.randomBool()) {
                success("Success!")
            } else {
                let error: NSError = NSError(domain: "ServerConnection.get", code: 1, userInfo: nil)
                failure(error)
            }
        })
    }
}
