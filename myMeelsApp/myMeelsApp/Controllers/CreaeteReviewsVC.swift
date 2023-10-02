//
//  CreaeteReviewsVC.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//

import UIKit

final class CreaeteReviewsVC: UIViewController {
    var index = 0
    private var mark = 1.0
    var image: CollectionViewCell?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var text: UITextView!
    @IBOutlet var warningLbl: UILabel!
    @IBOutlet var starControl: UISegmentedControl!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
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
        DataM.shared.foods[index].ratingArray.append(Reviews(text: text.text, mark: mark))
        dismiss(animated: true)
    }
}

extension CreaeteReviewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return cell1 }
        
        cell.image = image?.image

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cameraIcon = UIImage(named: "camera")
        let photoIcon = UIImage(named: "photo")
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.image?.image.image = image
        dismiss(animated: true)
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
}
