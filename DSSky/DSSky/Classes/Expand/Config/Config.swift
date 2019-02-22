//
//  Config.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/21.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

// MARK: - API相关
struct API {
    static let key = "4068ae35907f11d0a02cfe0578c924a8"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}

struct kAPPKEY {
    static let aMap = "4a643e86035b4f97241cd2e4c06d8fc4"
}

// MARK: - 全局尺寸
/// 主屏幕
struct kScreen {
    /// 主屏幕--尺寸
    static let bounds: CGRect = UIScreen.main.bounds
    /// 主屏幕--宽
    static let width: CGFloat = UIScreen.main.bounds.size.width
    /// 主屏幕--高
    static let height: CGFloat = UIScreen.main.bounds.size.height
}

// MARK: - 全局高度
struct kHeight {
    static let d003: CGFloat = 0.33
    static let d005: CGFloat = 0.5
    static let d02: CGFloat = 2
    static let d05: CGFloat = 5
    static let d06: CGFloat = 6
    static let d08: CGFloat = 8
    static let d10: CGFloat = 10
    static let d12: CGFloat = 12
    static let d15: CGFloat = 15
    static let d18: CGFloat = 18
    static let d20: CGFloat = 20
    static let d21: CGFloat = 21
    static let d30: CGFloat = 30
    static let d35: CGFloat = 35
    static let d37: CGFloat = 37
    static let d50: CGFloat = 50
    static let d44: CGFloat = 44
    static let d45: CGFloat = 45
    static var tabBar: CGFloat {
        return 49 + safeArea.bottom
    }
    static let navBar: CGFloat = 44 + kHeight.status
    static let status: CGFloat = UIApplication.shared.statusBarFrame.height
    /// 底部安全距离
    static var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *), let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets {
            return safeArea
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 全局颜色
struct kColor {
    /// 白色
    static let white = UIColor.white
    /// 绿色
    static let green = UIColor.green
    /// 棕色
    static let brown = UIColor.brown
    /// 黑色
    static let black = UIColor.black
    /// gray
    static let gray = UIColor.gray
    /// darkText
    static let darkText = UIColor.darkText//UIColor.init(hexString: "#313131")
    /// tableView 背景色
    static let groupTableViewBackground = UIColor.groupTableViewBackground
    /// 无色
    static let clear = UIColor.clear
    static let disabled = UIColor(hex: "d4d4d6")
    /// 浅灰色文案
    static let lightGray = UIColor.lightGray
    /// 分割线、轮播点
    static let line = UIColor(hex: "d6d5d9")
    
    /// 主色、标题部分
    static let main = UIColor(hex: "#ff7517")
}

// MARK: - 判断屏幕类型
public let UI_IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
public let UI_IS_IPHONE = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
public let UI_IS_IPHONE_4 = (UI_IS_IPHONE && kScreen.height < 568)
public let UI_IS_IPHONE_5 = (UI_IS_IPHONE && kScreen.height ~= 568)
public let UI_IS_IPHONE_6 = (UI_IS_IPHONE && kScreen.height ~= 667)
public let UI_IS_IPHONE_6P = (UI_IS_IPHONE && kScreen.height ~= 736)
/// 全面屏手机（iPhone X，iPhone XS，iPhone XS Max， iPhone XR）
public var UI_IS_IPHONE_FULLSCREEN: Bool {
    var isIPhoneXSeries: Bool = false
    if #available(iOS 11.0, *), UI_IS_IPHONE {
        if let window = UIApplication.shared.delegate?.window as? UIWindow,
            window.safeAreaInsets.bottom > CGFloat(0) {
            isIPhoneXSeries = true
        }
    }
    return isIPhoneXSeries
}

// MARK: - 全局时间
/// 全局时间
struct kTime {
    static let d_01: TimeInterval = 0.1
    static let duration: TimeInterval = 0.25
    /// 全局时间：1秒
    public let d_1: Int = 1
    /// 全局时间：一天
    static let day1: TimeInterval = 60 * 60 * 24
    /// 获取验证码倒计时的时间
    static let authCodeTime = 120
    /// 用于请求网络成功后延时一会儿，然后处理接下来的时间
    static let after1s = DispatchTime.now() + .seconds(1)
    /// 延时0.25秒
    static let afterDuration = DispatchTime.now() + 0.25
}

// MARK: - Notification
/// 全局快捷获取通知
public let kNotiCenter = NotificationCenter.default

public extension NSNotification.Name {
    // 登录成功，切换至登录成功的界面
    static let kUserLoginSuccess = Notification.Name(rawValue: "kUserLoginSuccess")
}

// MARK: - UserDefaults
/// 全局快捷获取UserDefaults
public let kUserDefaults = UserDefaults.standard
/// UserDefaults的 key 名字
struct kUDKey {
    static let notiTime = "notiTime"
}
