//
//  ActivityIndikator.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.07.2023.
//

import UIKit

enum ActivateIndikatior {
    case on, off
}

class ActivityIndikator {

    private let activityIndikator = UIActivityIndicatorView()
    private let view = UIView()
    private let imageView = UIImageView()
    
    func setupView() -> UIView {
        view.addSubview(indikator())
        return view
    }
    
    func indikator() -> UIActivityIndicatorView {
        activityIndikator.frame = view.frame
        let images: [UIImage] = returnArrayUIImage()
        imageView.animationImages = images
        imageView.animationDuration = 2.0
        imageView.animationRepeatCount = 0
        imageView.frame = CGRect(origin: CGPoint(x: view.frame.maxX / 2 - 150,
                                                 y: view.frame.maxY / 2 - 150),
                                 size: CGSize(width: 300,
                                              height: 300))
        imageView.startAnimating()
        activityIndikator.addSubview(imageView)
        activityIndikator.center = view.center
        activityIndikator.backgroundColor = .white
        return activityIndikator
    }
    
    func takeFrame(frame: CGRect) { view.frame = frame}
    
    func activate(_ active: ActivateIndikatior) {
        switch active {
        case .on:
            imageView.startAnimating()
            indikator().startAnimating()
        case .off:
            imageView.stopAnimating()
            indikator().stopAnimating()
            setupView().removeFromSuperview()
        }
    }
    
    func returnArrayUIImage() -> [UIImage] {
        var images: [UIImage] = []
        for num in 1...75 {
           let image = UIImage(named: "portal-rick-and-morty-\(num)")
            if let image {
                images.append(image)
            }
        }
        return images
    }
}
