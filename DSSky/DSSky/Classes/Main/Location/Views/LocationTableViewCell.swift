//
//  LocationTableViewCell.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    // MARK: - Property
    static let reuseID = "LocationTableViewCell"
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Method
    func showData(_ vm: LocationProtocol) {
        label.text = vm.labelText
    }

}
