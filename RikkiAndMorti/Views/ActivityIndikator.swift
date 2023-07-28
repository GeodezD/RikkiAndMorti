//
//  ActivityIndikator.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.07.2023.
//

import UIKit

class ActivityIndikator: UIImage, ActivityIndikatorDelegate {
    private let activityIndikator = UIActivityIndicatorView()
    private let view = UIView()
    private let imageView = UIImageView()
    
    func setupView() -> UIView {
        view.frame = view.frame
        view.addSubview(indikator())
        return view
    }
    
    func indikator() -> UIActivityIndicatorView {
        activityIndikator.style = .large
        activityIndikator.frame = view.frame
        imageView.image = UIImage(named: "teleport")
        imageView.frame = view.frame
        imageView.animationImages = imageView.image?.images
        imageView.animationDuration = imageView.image?.duration ?? 1.0
        
        imageView.startAnimating()
        activityIndikator.addSubview(imageView)
        activityIndikator.center = view.center
        activityIndikator.color = .red
        activityIndikator.backgroundColor = .white
        return activityIndikator
    }
}
