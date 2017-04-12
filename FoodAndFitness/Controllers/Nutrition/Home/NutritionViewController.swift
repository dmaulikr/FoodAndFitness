//
//  NutritionViewController.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 3/23/17.
//  Copyright © 2017 SuHoVan. All rights reserved.
//

import UIKit
import SwiftUtils

final class NutritionViewController: BaseViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!

    enum Section: Int {
        case progress
        case meals

        static var count: Int {
            return self.meals.hashValue + 1
        }

        var numberOfRows: Int {
            switch self {
            case .progress:
                return 1
            case .meals:
                return 3
            }
        }

        var heightForRows: CGFloat {
            switch self {
            case .progress:
                return 200
            default:
                return 100
            }
        }
    }

    // MARK: - Cycle Life
    override var isNavigationBarHidden: Bool {
        return true
    }

    override func setupUI() {
        super.setupUI()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureTableView() {
        tableView.register(ProgressCell.self)
        tableView.register(MealCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension NutritionViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nutritionSection = Section(rawValue: section) else { fatalError(Strings.Errors.enumError) }
        return nutritionSection.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nutritionSection = Section(rawValue: indexPath.section) else { fatalError(Strings.Errors.enumError) }
        switch nutritionSection {
        case .progress:
            let cell = tableView.dequeue(ProgressCell.self)
            cell.setup(45, duration: 2)
            return cell
        case .meals:
            let cell = tableView.dequeue(MealCell.self)
            return cell
        }
    }
}
// MARK: - UITableViewDelegate
extension NutritionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let nutritionSection = Section(rawValue: indexPath.section) else { fatalError(Strings.Errors.enumError) }
        return nutritionSection.heightForRows
    }
}
