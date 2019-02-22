//
//  DSPrivacyIsAuthorized.swift
//  YXJY
//
//  Created by 左得胜 on 2019/2/15.
//  Copyright © 2019 找油网. All rights reserved.
//

import Foundation
import Photos
import UserNotifications

// TODO: - 未完成，待续……
class DSPrivacyIsAuthorized {
    /// 检测是否打开相册权限
    class func openPhotosService(completion: @escaping ((_ isOpen: Bool) -> Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (sta) in
                if sta == .authorized {
                    completion(true)
                }
            }
        case .authorized:
            completion(true)
        default:
            completion(false)
        }
        
    }
    
    /// 检测是否开启相机权限
    class func openCaptureService(completion: @escaping ((_ isOpen: Bool) -> Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                completion(granted)
            }
        case .authorized:
            completion(true)
        default:
            completion(false)
        }
    }
    
    /// 检测是否开启定位权限
    class func openLocationService(completion: @escaping ((_ isOpen: Bool) -> Void)) {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .notDetermined:
             CLLocationManager().requestWhenInUseAuthorization()
        default:
            completion(false)
        }
    }
    
    /// 检测推送权限
    class func openPushService(completion: @escaping ((_ isOpen: Bool) -> Void)) {
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
//                case .notDetermined:
//
                case .denied:
                    completion(false)
                default:
                    completion(true)
                }
            }
        } else if #available(iOS 8, *) {
            guard let setting = UIApplication.shared.currentUserNotificationSettings else { return }
            if setting.types == UIUserNotificationType.init(rawValue: 0) {
                completion(false)
            } else {
                completion(true)
            }
        }
        
    }
    
    /// 打开系统设置
    class func openSettings(message: String = "为了及时收到新订单，请打开启老吕加油的通知功能") {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIAlertController.show(title: "温馨提醒", message: message, preferredStyle: .alert, cancel: "下次再说", cancelHandler: { (_) in
                kUserDefaults.set(Date(timeIntervalSinceNow: kTime.day1), forKey: kUDKey.notiTime)
            }, confirm: "设置", confirmHandler: { (_) in
                if let url = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            })
        }
    }
}
