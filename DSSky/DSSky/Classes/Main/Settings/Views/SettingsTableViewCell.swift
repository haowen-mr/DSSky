//
//  SettingsTableViewCell.swift
//  DSSky
//
//  Created by 左得胜 on 2019/2/28.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: - Property
    static let reuseID = "SettingsTableViewCell"
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public Method
    func showData(_ vm: SettingsProtocol) {
        accessoryType = vm.accessory
        label.text = vm.labelText
    }
}

// MARK: - Private Method
private extension SettingsTableViewCell {
    func setupUI() {
//        selectionStyle = .none
    }
}
