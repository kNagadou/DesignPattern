//
//  DelegatePattern.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

protocol DelegatePatternDelegate {
    func success(response: String)
    func error(error: NSError)
}

class DelegatePattern {
    var delegate: DelegatePatternDelegate?
    
    func doing() {
        
        Stub_ServerConnection.get(success: { (respose) in
            print(respose)
            self.delegate?.success(response: respose.appending("Delegate Pattern で実行しました"))
        }) { (error) in
            print(error)
            self.delegate?.error(error: error)
        }
    }
}
