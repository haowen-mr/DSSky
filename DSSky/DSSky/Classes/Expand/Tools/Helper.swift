//
//  Helper.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

// MARK: - 自定义打印信息
/// 可变参打印函数
///
/// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single space (`" "`).
///   - terminator: The string to print after all items have been printed. The  default is a newline (`"\n"`).
///   - file: 文件名，默认值：#file
///   - line: 第几行，默认值：#line
///   - function: 函数名，默认值：#function
func QL1(_ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line,
    function: String = #function) {
    #if DEBUG
    print("\((file as NSString).pathComponents.last!):\(line) \(function):", terminator: separator)
    let count = items.count - 1
    for (i, item) in items.enumerated() {
        print(item, terminator: i == count ? terminator : separator)
    }
    #endif
}

/// 自定义打印=================
func QLShortLine(_ file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let lineString = "======================================"
    print("\((file as NSString).pathComponents.last!):\(line) \(function): \(lineString)")
    #endif
}

/// 自定义打印+++++++++++++++++++
func QLPlusLine(_ file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let lineString = "+++++++++++++++++++++++++++++++++++++"
    print("\((file as NSString).pathComponents.last!):\(line) \(function): \(lineString)")
    #endif
}

/// 根据设计稿的像素值返回实际物理值【以4.7英寸宽(375.0, 667.0)为基准】
///
/// - Parameter value: 像素值
/// - Returns: 实际物理值
func kw(_ value: CGFloat) -> CGFloat {
    return UIScreen.main.bounds.width / 375 * value
    //    return CGFloat(Int(UIScreen.main.bounds.width / 375 * value))
}

//MARK: - 全局打电话
/// 全局打电话
///
/// - parameter phoneNumber: 要拨打的电话号码
func global_phone(with phoneNumber: String, isShowActionSheet: Bool = true) {
    if isShowActionSheet {
        UIAlertController.show(title: "拨打电话：", message: nil, preferredStyle: .actionSheet) { (_) in
            callPhone(phoneNumber: phoneNumber)
        }
    } else {
        callPhone(phoneNumber: phoneNumber)
    }
    
}

private func callPhone(phoneNumber: String) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL.init(string: "telprompt://\(phoneNumber)")!,
                                  options: [:],
                                  completionHandler: nil)
    } else {
        UIApplication.shared.openURL(URL(string: "tel://\(phoneNumber)")!)
    }
}

