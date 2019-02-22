//
//  HUD.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/22.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation
import MBProgressHUD

enum HUDType {
    /// 带有成功图片
    case success
    /// 带有错误图片
    case error
    /// 带有菊花转图片
    case loading
    /// 带有警告图片
    case warning
    /// 纯文本展示
    case text
    /// 自定义图片【也可以传入 GIF】
    case image(image: UIImage)
    /// 序列帧图片数组
    case animationImages(images: [UIImage])
    /// GIF 动图
    case gif(gifName: String)
}

enum HUDAnimationOptions {
    /// 无动画
    case none
    /// 缩放动画
    case zoom
    /// 从顶部下滑
    case transitionFlipFromTop
    /// 从底部上滑
    case transitionFlipFromBottom
}

class HUD {
    /// HUD 按钮点击闭包别名
    typealias HUDRefreshClosure = (() -> Void)
    /// HUD 按钮点击闭包
    static var refreshClosure: HUDRefreshClosure?
    
    // MARK: - Public Method
    class func show(_ type: HUDType, message: String? = nil, to view: UIView? = UIApplication.shared.keyWindow, isUserEnable: Bool = true, offset: CGPoint = CGPoint.zero, animations: HUDAnimationOptions = .zoom) {
        if let view = view {
            switch type {
            case .success:
                show(.customView, message: message, icon: #imageLiteral(resourceName: "hud_success"), view: view, isUserEnable: isUserEnable, isAutoHide: true, offset: offset, animations: animations)
            case .error:
                show(.customView, message: message, icon: #imageLiteral(resourceName: "hud_error"), view: view, isUserEnable: isUserEnable, isAutoHide: true, offset: offset, animations: animations)
            case .loading:
                show(.indeterminate, message: message, icon: nil, view: view, isUserEnable: false, isAutoHide: false, offset: offset, animations: .none)
            case .warning:
                show(.customView, message: message, icon: #imageLiteral(resourceName: "hud_warning"), view: view, isUserEnable: isUserEnable, isAutoHide: true, offset: offset, animations: animations)
            case .text:
                show(.text, message: message, icon: nil, view: view, isUserEnable: isUserEnable, isAutoHide: true, offset: offset, animations: animations)
            case .image(let image):
                show(.customView, message: message, icon: image, view: view, isUserEnable: false, isAutoHide: false, offset: offset, animations: animations)
            case .animationImages(let images):
                showAnimationImages(message: message, images: images, view: view, isUserEnable: false, isAutoHide: false, offset: offset, animations: animations)
            case .gif(let gifName):
                showGIF(message: message, gifName: gifName, view: view, isUserEnable: false, isAutoHide: false, offset: offset, animations: animations)
            }
        }
    }
    
    /// 隐藏指定 view 上面的一个 HUD
    class func hide(_ view: UIView? = UIApplication.shared.keyWindow, animated: Bool = true) {
        if let view = view {
            MBProgressHUD.hide(for: view, animated: animated)
        }
    }
    
    @discardableResult
    class func showNetError(message: String?, icon: UIImage? = nil, to view: UIView, offset: CGPoint = CGPoint.zero, refreshClosure: HUDRefreshClosure? = nil) -> MBProgressHUD {
        HUD.hide(view, animated: false)
        // 快速显示提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: false)
        //设置模式
        hud.mode = MBProgressHUDMode.customView
        //隐藏时候从父控件移除
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.backgroundColor = UIColor.clear
        hud.backgroundColor = UIColor.white
        hud.detailsLabel.text = message
        
        if let icon = icon {
            hud.customView = UIImageView(image: icon)
        } else {
            hud.customView = UIImageView(image: UIImage(named: "error_img"))
        }
        
        hud.customView?.tintColor = UIColor.init(red: 51/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1)
        
        if let refreshClosure = refreshClosure {
            hud.detailsLabel.text = (message ?? "") + "\n点击空白处刷新"
            hud.detailsLabel.font = UIFont.fontOfDP(ofSize: 12)
            hud.detailsLabel.textColor = UIColor(hex: "9a9a9a")
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hudTapClick(tap:)))
            hud.addGestureRecognizer(tap)
            self.refreshClosure = refreshClosure
        }
        hud.offset = offset
        
        return hud
    }
    
    @discardableResult
    class func showCustom(message: String?, icon: UIImage?, font: UIFont? = nil, to view: UIView, backgroundColor: UIColor = UIColor.white, offset: CGPoint = CGPoint.zero, refreshClosure: HUDRefreshClosure?) -> MBProgressHUD {
        HUD.hide(view, animated: false)
        // 快速显示提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: false)
        //设置模式
        hud.mode = .customView
        //隐藏时候从父控件移除
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.color = UIColor.clear
        hud.backgroundColor = backgroundColor
        hud.detailsLabel.text = message
        if let font = font {
            hud.detailsLabel.font = font
        }
        
        hud.customView = UIImageView(image: icon ?? UIImage(named: "empty_img-1"))
        hud.customView?.tintColor = UIColor.init(red: 34/255.0, green: 23/255.0, blue: 20/255.0, alpha: 1)
        
        if let refreshClosure = refreshClosure {
            hud.detailsLabel.text = (message ?? "") + "\n点击空白处刷新"
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hudTapClick(tap:)))
            hud.addGestureRecognizer(tap)
            self.refreshClosure = refreshClosure
        }
        hud.frame.origin = offset
        hud.offset = CGPoint(x: -offset.x*0.7, y: -offset.y*0.7)
        
        return hud
    }
}

private extension HUD {
    @discardableResult
    private class func showGIF(message: String?, gifName: String, view: UIView, isUserEnable: Bool = false, isAutoHide: Bool = true, offset: CGPoint = CGPoint.zero, animations: HUDAnimationOptions) -> MBProgressHUD {
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = !isUserEnable
        hud.mode = .customView
        let iv = UIImageView()
        iv.setupGif(gifName)
        hud.customView = iv
        setupHUD(message: message, hud: hud, offset: offset, animations: animations, isAutoHide: isAutoHide)
        
        return hud
    }
    
    @discardableResult
    private class func showAnimationImages(message: String?, images: [UIImage], view: UIView, isUserEnable: Bool = false, isAutoHide: Bool = true, offset: CGPoint = CGPoint.zero, animations: HUDAnimationOptions) -> MBProgressHUD {
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = !isUserEnable
        hud.mode = .customView
        let iv = UIImageView()
        iv.setupAnimationImages(images)
        hud.customView = iv
        setupHUD(message: message, hud: hud, offset: offset, animations: animations, isAutoHide: isAutoHide)
        
        return hud
    }
    
    @discardableResult
    private class func show(_ mode: MBProgressHUDMode, message: String?, icon: UIImage?, view: UIView, isUserEnable: Bool = false, isAutoHide: Bool = true, offset: CGPoint = CGPoint.zero, animations: HUDAnimationOptions) -> MBProgressHUD {
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = !isUserEnable
        hud.mode = mode
        if mode == .customView {
            hud.customView = UIImageView(image: icon)
        }
        setupHUD(message: message, hud: hud, offset: offset, animations: animations, isAutoHide: isAutoHide)
        
        return hud
    }
    
    /// 通用 HUD 的样式设置
    private class func setupHUD(message: String?, hud: MBProgressHUD, offset: CGPoint, animations: HUDAnimationOptions, isAutoHide: Bool) {
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        hud.contentColor = UIColor.white
        hud.detailsLabel.text = message
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 16)
        hud.margin = 15
        //隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        
        switch animations {
        case .zoom:
            hud.animationType = .zoomOut
            hud.offset = offset
            
            hud.bezelView.layer.opacity = 0.5
            hud.bezelView.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1.0)
            UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                hud.bezelView.layer.opacity = 0.9
                hud.bezelView.layer.transform = CATransform3DMakeScale(1, 1, 1.0)
            })
        case .transitionFlipFromBottom:
            hud.layoutIfNeeded()
            hud.offset = CGPoint(x: 0, y: hud.bezelView.frame.minY - offset.y)
            
            hud.bezelView.frame.origin.y = kScreen.height * 0.5
            UIView.animate(withDuration: 0.25, animations: {
                hud.bezelView.frame.origin.y = hud.offset.y
            })
        case .transitionFlipFromTop:
            hud.layoutIfNeeded()
            hud.offset = CGPoint(x: 0, y: -hud.bezelView.frame.minY + offset.y)
            
            hud.bezelView.frame.origin.y = -kScreen.height * 0.5
            UIView.animate(withDuration: 0.25, animations: {
                hud.bezelView.frame.origin.y = -hud.offset.y
            })
        default:
            hud.offset = offset
            break
        }
        
        if isAutoHide {// 是否自动消失
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    
    /// HUD 中的重试按钮点击【记得手动隐藏掉展示的 HUD 】
    @objc private class func hudTapClick(tap: UITapGestureRecognizer) {
        HUD.hide(tap.view?.superview, animated: false)
        refreshClosure?()
    }
    
}

extension UIImageView {
    /// 设置序列帧图片数组
    func setupAnimationImages(_ images: [UIImage], isRepeat: Bool = true) {
        animationImages = images
        animationDuration = Double(images.count) * 0.1
        animationRepeatCount = isRepeat ? 0 : 1
        startAnimating()
    }
    
    /// 设置 GIF
    func setupGif(_ gifName: String) {
        // 获取NSData类型，根据Data获取CGImageSource对象
        guard let filePath = Bundle.main.path(forResource: gifName, ofType: ".gif"),
            let fileData = NSData(contentsOfFile: filePath),
            let imageSource = CGImageSourceCreateWithData(fileData, nil) else {
                print(#file, #line, "设置 GIF 路径和 data 出错，请检查！")
                return
        }
        
        // 获取gif图片中图片的个数
        let gifcount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<gifcount {
            // 获取图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            images.append(UIImage(cgImage: cgImage))
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil),
                let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else { continue }
            totalDuration += frameDuration.doubleValue
        }
        animationImages = images// 播放图片
        animationDuration = totalDuration// 播放时间
        animationRepeatCount = 0// 播放次数, 0为无限循环
        startAnimating()// 开始播放
    }
}
