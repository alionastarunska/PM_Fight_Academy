//
//  CustomRightView.swift
//  FightAcademy
//
//  Created by Павел Снижко on 24.03.2021.
//

import UIKit

class CustomRightView: UIView, NibLoadable {
    
    @IBOutlet private weak var defaultCleanImage: UIImageView!
    @IBOutlet private weak var imageForChanging: UIImageView!
    
    var cleanIconTapped: VoidClosure?
    var imageForChangingTapped: VoidClosure?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUpGestureRecognizers()
    }
    
    func setImage(with image: UIImage) {
        self.imageForChanging.image = image
        layoutIfNeeded()
    }
       
    private func setUpGestureRecognizers() {
        let firstGesture = UITapGestureRecognizer(target: self,
                                                  action: #selector(tappedCleanIcon(tapGestureRecognizer:)))
        defaultCleanImage.isUserInteractionEnabled = true
        defaultCleanImage.addGestureRecognizer(firstGesture)
        
        let secondGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(tappedImageForChanging(tapGestureRecognizer:)))
        imageForChanging.isUserInteractionEnabled = true
        imageForChanging.addGestureRecognizer(secondGesture)

    }

    @objc private func tappedCleanIcon(tapGestureRecognizer: UITapGestureRecognizer) {
        cleanIconTapped?()
    }
    
    @objc private func tappedImageForChanging(tapGestureRecognizer: UITapGestureRecognizer) {
        imageForChangingTapped?()
    }
}
