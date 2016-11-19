//
//  BaseCell.swift
//  C4QStudentBook
//
//  Created by Jason Wang on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell() {
    }
}
