//
//  ProfileViewController.swift
//  MapApp
//
//  Created by Lewis on 03.06.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let imageSaver = ImageSaverToFiles()
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func setAvatar(_ sender: Any) {
        createActionSheetAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        profileImageView.image = imageSaver.loadImageFromDisk(fileName: Constants.savedAvatarImageFileNameString) ?? UIImage(named: "noImage")
    }
    
    private func setupController() {
        navigationController?.navigationBar.topItem?.title = UserDefaults.standard.string(forKey: "UserLoginName")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createActionSheetAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Take Picture",
                                                style: .default,
                                                handler: { [weak self] _ in
            guard let self = self else { return }
            self.openPickerControllerOn(.camera)
        }))
        
        alertController.addAction(UIAlertAction(title: "Choose from library",
                                                style: .default,
                                                handler: { [weak self] _  in
            guard let self = self else { return }
            self.openPickerControllerOn(.library)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    private func openPickerControllerOn(_ source: ImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let imagePickerController = UIImagePickerController()
        switch source {
        case .camera:
            imagePickerController.sourceType = .camera
        case .library:
            imagePickerController.mediaTypes = ["public.image"]
        }
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        profileImageView.image = image
        reloadInputViews()
        imageSaver.saveImageToDisk(imageName: Constants.savedAvatarImageFileNameString, image: image)
        NotificationCenter.default.post(name: NSNotification.Name("ProfileControllerMadeNewImage"), object: nil)
        picker.dismiss(animated: true)
    }
}
