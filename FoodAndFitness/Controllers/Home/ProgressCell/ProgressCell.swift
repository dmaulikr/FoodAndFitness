//
//  ProgressCell.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 4/6/17.
//  Copyright © 2017 SuHoVan. All rights reserved.
//

import UIKit

final class ProgressCell: BaseTableViewCell {
    @IBOutlet fileprivate(set) weak var progressView: CircleProgressView!
    @IBOutlet fileprivate(set) weak var caloriesLabel: UILabel!
    @IBOutlet fileprivate(set) weak var eatenLabel: UILabel!
    @IBOutlet fileprivate(set) weak var burnLabel: UILabel!
    @IBOutlet fileprivate(set) weak var carbsLabel: UILabel!
    @IBOutlet fileprivate(set) weak var proteinLabel: UILabel!
    @IBOutlet fileprivate(set) weak var fatLabel: UILabel!

    struct Data {
        var calories: Int
        var eaten: Int
        var burn: Int
        var carbs: String
        var protein: String
        var fat: String
    }

    var data: Data? {
        didSet {
            guard let data = data else { return }
            progressView.maxValue = CGFloat(data.calories)
            progressView.setValue(CGFloat(data.eaten))
            progressView.setNeedsDisplay()
            progressView.setNeedsLayout()
            caloriesLabel.text = "\(data.calories - data.eaten)"
            eatenLabel.text = "\(data.eaten)"
            burnLabel.text = "\(data.burn)"
            carbsLabel.text =  data.carbs
            proteinLabel.text = data.protein
            fatLabel.text = data.fat
        }
    }
}
