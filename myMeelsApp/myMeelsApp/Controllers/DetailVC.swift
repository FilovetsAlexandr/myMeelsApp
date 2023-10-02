//
//  DetailVC.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//
import UIKit

final class DetailVC: UIViewController {

    var currentFood: Food!
    var foodIndex: Int?

    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var buttonRvs: UIButton!
    @IBOutlet weak var starRating: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFood()
    }

    @IBAction func goReviews() {
    }

    private func setupFood() {
        guard let foodIndex = foodIndex else {
            return }
        buttonRvs.setTitle("Посмотреть (\(DataM.shared.foods[foodIndex].ratingArray.count)) отзывов", for: .normal)
        priceLbl.text = String(currentFood.price) + " BYN"
        imageDetail.image = currentFood.image
        nameLbl.text = currentFood.name
        starRating.text = currentFood.ratingStar
        let data = DataM.shared.foods[foodIndex]
        if data.rating == nil {
            buttonRvs.isEnabled = false
            starRating.text = "Нет отзывов"
        } else {
            buttonRvs.isEnabled = true
            starRating.text = DataM.shared.foods[foodIndex].ratingStar
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoCreateVC" {
            guard let destination = segue.destination as? CreaeteReviewsVC else { return }
            destination.index = foodIndex!
        }
        if segue.identifier == "goReviews" {
            guard let destination = segue.destination as? ReviewsVC else { return }
            destination.index = foodIndex!
        }
    }
}
