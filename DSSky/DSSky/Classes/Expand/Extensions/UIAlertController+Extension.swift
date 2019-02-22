//
//  UIAlertController+Extension.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func show(title: String?,
                    message: String?,
                    preferredStyle: UIAlertController.Style = .alert,
                    cancel: String = "取消",
                    cancelHandler: ((UIAlertAction) -> Void)? = nil,
                    confirm: String = "确定",
                    confirmHandler: ((UIAlertAction) -> Void)? = nil) {
        guard let vc = currentVC(), !vc.isKind(of: UIAlertController.classForCoder()) else { return }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UI_IS_IPAD ? .alert : preferredStyle)
        if let cancelHandler = cancelHandler {
            let action = UIAlertAction(title: cancel, style: .cancel, handler: cancelHandler)
            action.setValue(UIColor.darkText, forKey: "titleTextColor")
            alertVC.addAction(action)
        } else {
            alertVC.addAction(UIAlertAction(title: "确定", style: .cancel, handler: cancelHandler))
        }
        if let confirmHandler = confirmHandler {
            let action = UIAlertAction(title: confirm, style: .default, handler: confirmHandler)
            action.setValue(kColor.main, forKey: "titleTextColor")
            alertVC.addAction(action)
        }
        
        vc.present(alertVC, animated: true, completion: nil)
    }
}
