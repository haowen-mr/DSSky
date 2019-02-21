//
//  Double+Extension.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

extension Double {
    /// 华氏度转换为摄氏度
    func toCelsius() -> Double {
        return (self - 32.0) / 1.8
    }
}
