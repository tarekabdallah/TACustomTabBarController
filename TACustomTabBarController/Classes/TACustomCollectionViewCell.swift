//
//  TACustomCollectionViewCell.swift
//  CustomTabBarController
//
//  Created by Apple on 5/19/17.
//  Copyright © 2017 Tarek. All rights reserved.
//

import UIKit
/**
    Text position with respect to the image.
 
 - aboveImage
 - belowImage
 - toTheLeftOfImage
 - toTheRightOfImage
 
 */

@objc public enum ItemTextPosition: Int{
    case aboveImage = 0, belowImage = 1, toTheLeftOfImage = 2, toTheRightOfImage = 3
}
class TACustomCollectionViewCell: UICollectionViewCell {
    internal var titleTextPosition: ItemTextPosition!
    internal let titleImageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 5, height: 5)))
    internal let titleLabel = UILabel()
    internal var inactiveImage:UIImage?
    internal var selectedImage:UIImage?
    internal var selectedColor:UIColor?
    internal var inactiveColor:UIColor?
    override var isSelected: Bool {
        didSet{
            if isSelected{
                titleImageView.image = selectedImage ?? inactiveImage
                titleLabel.textColor = selectedColor
            }
            else{
                titleImageView.image = inactiveImage
                titleLabel.textColor = inactiveColor
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        isSelected = !(!isSelected)
        setImageView()
        setTextPosition()
        if !isSelected{
            titleLabel.backgroundColor = backgroundColor
            titleLabel.textColor = inactiveColor
        }
    }
    private func setImageView(){
        self.addSubview(titleImageView)
        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        titleImageView.heightAnchor.constraint(equalTo: titleImageView.widthAnchor).isActive = true
    }
    
    private func setTextPosition(){
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if titleImageView.image == nil{
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            return
        }
        if titleTextPosition == .toTheRightOfImage{
            titleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.titleImageView.centerYAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 17).isActive = true
            titleImageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -4).isActive = true
        }
        else if titleTextPosition == .toTheLeftOfImage{
            titleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.titleImageView.centerYAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -17).isActive = true
            titleImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -4).isActive = true
        }
        else if titleTextPosition == .aboveImage{
            titleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 4).isActive = true
            titleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: self.titleImageView.centerXAnchor, constant: 0).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: titleImageView.topAnchor, constant: 0).isActive = true
        }
        else{
            titleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -4).isActive = true
            titleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: self.titleImageView.centerXAnchor, constant: 0).isActive = true
            titleLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 2).isActive = true
            
        }
        
    }
    
    
}
