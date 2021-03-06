//
//  UITableView+Extension.swift
//  CrazyFutures
//
//  Created by 左得胜 on 2018/4/26.
//  Copyright © 2018年 左得胜. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 便利构造tableView
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - style: style
    ///   - estimatedRowHeight: 是否需要预估高度，否的话请为nil或省略该参数
    ///   - dataSource: UITableViewDataSource
    ///   - delegate: UITableViewDelegate
    convenience init(frame: CGRect, style: UITableView.Style, backgroundColor: UIColor = UIColor.groupTableViewBackground, estimatedRowHeight: CGFloat? = nil, config: ((_ tv: UITableView) -> Void)?) {
        self.init(frame: frame, style: style)
        
        self.backgroundColor = backgroundColor
        hideEmptyCells()
        if let estimatedRowHeight = estimatedRowHeight {
            rowHeight = UITableView.automaticDimension
            self.estimatedRowHeight = estimatedRowHeight
        }
        if let config = config {
            config(self)
        }
    }
    
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let identifier = String(describing: type.self)
        register(type, forCellReuseIdentifier: identifier)
    }
    
    func registerNibCell<T: UITableViewCell>(_ type: T.Type) {
        let cell = String(describing: type.self)
        register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(type.self) was not registered")
        }
        return cell
    }
    
    /// 隐藏 footer
    func hideEmptyCells() {
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = backgroundColor
        tableFooterView = footerView
    }
}
