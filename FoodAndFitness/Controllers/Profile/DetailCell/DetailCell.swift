//
//  DetailCell.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 5/8/17.
//  Copyright © 2017 SuHoVan. All rights reserved.
//

import UIKit

class DetailCell: BaseTableViewCell {
    @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
    @IBOutlet fileprivate(set) weak var detailLabel: UILabel!

    struct Data {
        var title: String
        var detail: String
        var detailColor: UIColor
    }

    var data: Data? {
        didSet {
            guard let data = data else { return }
            titleLabel.text = data.title
            detailLabel.text = data.detail
            detailLabel.textColor = data.detailColor
        }
    }
}
