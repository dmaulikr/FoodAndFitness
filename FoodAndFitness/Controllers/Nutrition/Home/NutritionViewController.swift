//
//  NutritionViewController.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 3/23/17.
//  Copyright © 2017 SuHoVan. All rights reserved.
//

import UIKit
import SwiftUtils

class NutritionViewController: BaseViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var progressView: CircleProgressView!
    
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
        progressView.setValue(740, duration: 5)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension NutritionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension NutritionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: NutritionProgressView = NutritionProgressView.loadNib()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
}
