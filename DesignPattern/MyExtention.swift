//
//  MyExtention.swift
//  DesignPattern
//
//  Created by Kazumasa Nagadou on 2017/07/02.
//  Copyright © 2017年 kNagadou. All rights reserved.
//

import UIKit

extension Bool {
    static func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

extension Thread {
    static func sleepAsync(forTimeInterval: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            Thread.sleep(forTimeInterval: forTimeInterval)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
