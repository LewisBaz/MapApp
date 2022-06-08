//
//  ProfileBarButtonItem.swift
//  MapApp
//
//  Created by Lewis on 03.06.2022.
//

import UIKit

final class ProfileBarButtonItem: UIButton {
    
    private let imageSaver = ImageSaverToFiles()
    private var buttonSize: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }
    
    init(frame: CGRect, size: CGFloat) {
        super.init(frame: frame)
        buttonSize = size
        self.setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupButtonLayer()
    }
    
    private func setupButtonLayer() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
    private func setUpView() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.setImage(imageSaver.loadImageFromDisk(fileName: Constants.savedAvatarImageFileNameString) ?? UIImage(named: "noImage"), for: .normal)
    }
}
