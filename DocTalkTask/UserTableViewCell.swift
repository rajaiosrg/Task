//
//  UserTableViewCell.swift
//  DocTalkTask
//
//  Created by Raja Earla on 13/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
