//
//  CreaeteReviewsVC.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//

import UIKit

final class CreaeteReviewsVC: UIViewController {
    private let defaultImage = UIImage(named: "photo.fill")
    private lazy var imagePicker: ImagePicker = { ImagePicker() }()
    private var mark = 1.0
    private var isImageSelected = false
    var index = 0
    
        
    
    @IBOutlet weak var deleteImageBtn: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var text: UITextView!
    @IBOutlet var warningLbl: UILabel!
    @IBOutlet var starControl: UISegmentedControl!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = defaultImage
        deleteImageBtn.isEnabled = false
        button.isEnabled = false
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
    }

    @IBAction func starCntrl(_ sender: UISegmentedControl) {
        if text.text.count <= 5 {
            warningLbl.isHidden = false
        } else {
            warningLbl.isHidden = true
            button.isEnabled = true
            let selectedMark = Double(sender.selectedSegmentIndex + 1) // добавляем 1, чтобы оценка была от 1 до 5
            mark = min(selectedMark, 5) // ограничиваем оценку до 5
        }
    }

    @IBAction func saveReviews() {
        let review = Reviews(text: text.text, mark: mark, image: imageView.image)
           DataM.shared.foods[index].ratingArray.append(review)
           dismiss(animated: true)
    }
    
    // Добавление и удаление изображения
    
    @IBAction func pushSelectImage(_ sender: Any) {
        imagePicker.showImagePicker(in: self) { image in
              self.imageView.image = image
              self.deleteImageBtn.isEnabled = true
              self.isImageSelected = true
          }
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        self.imageView.image = defaultImage
        self.deleteImageBtn.isEnabled = false
        self.isImageSelected = false
    }
    
    // Скрытие клавиатуры при нажатии на пустой обьект на экране
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
}
