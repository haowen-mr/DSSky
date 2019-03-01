//
//  Notifications.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

// MARK: - Notification
/// 全局快捷获取通知
public let kNotiCenter = NotificationCenter.default

public extension NSNotification.Name {
    // 登录成功，切换至登录成功的界面
    static let kUserLoginSuccess = Notification.Name(rawValue: "kUserLoginSuccess")
}

