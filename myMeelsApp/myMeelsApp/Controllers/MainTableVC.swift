//
//  ViewController.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//

import UIKit

final class MainTableVC: UITableViewController {

    var foodIndex = 0
    // For animation
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        loadImageAsync()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: { self.animate() })
    }
    private func loadImageAsync() {
        DispatchQueue.global().async {
            if let image = UIImage(named: "logo") {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        })
    }
    override func viewWillAppear(_ animated: Bool) { tableView.reloadData() }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { DataM.shared.foods.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainCustomTVC {
            let eat = DataM.shared.foods[indexPath.row]
            cell.nameLbl.text = eat.name
            cell.imageV.image = eat.image
            cell.priceLbl.text = String(eat.price) + "BYN"
            cell.ratingLbl?.text = eat.ratingStar
            return cell
        } else { return defaultCell }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let detailVC = segue.destination as? DetailVC,
              let selectedFood = DataM.shared.foods[safe: indexPath.row] else { return }
        detailVC.currentFood = selectedFood
        detailVC.navigationItem.title = selectedFood.name
        detailVC.foodIndex = indexPath.row
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


