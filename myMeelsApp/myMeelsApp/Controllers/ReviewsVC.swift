//
//  ReviewsVC.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 26.09.23.
//

import UIKit

final class ReviewsVC: UITableViewController {
    var index = 0

    override func viewDidLoad() { super.viewDidLoad() }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { DataM.shared.foods[index].ratingArray.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "ReviewsCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as? CustomTVC else { return defaultCell }

        let reviews = DataM.shared.foods[index].ratingArray
        
        cell.dateLbl.text = reviews[indexPath.row].dateStr
        cell.ratingLbl.text = reviews[indexPath.row].rating
        cell.textLbl.text = reviews[indexPath.row].text
        cell.customImageView.image = reviews[indexPath.row].image

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}
