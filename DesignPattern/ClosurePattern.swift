//
//  BlockPattern.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

class ClosurePattern: NSObject {
    
    static func doing(success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        Stub_ServerConnection.get(success: { (response) in
            print(response)
            success(response.appending("Closure Pattern で実行しました"))
        }) { (error) in
            print(error)
            failure(error)
        }
    }

}
