//
//  SingletonPattern.swift
//  DesignPattern
//
//  Created by k_nagadou on 2017/07/11.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

class SingletonPattern {
    static let instance: SingletonPattern = SingletonPattern()
    private init() {}
    
    func doing(success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        Stub_ServerConnection.get(success: { (response) in
            print(response)
            success(response.appending("Singleton Pattern で実行しました"))
        }) { (error) in
            print(error)
            failure(error)
        }
    }
}
