//
//  ActivityIndikator.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.07.2023.
//

import UIKit

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
        imageView.image = UIImage(named: "teleport")
        imageView.frame = activityIndikator.frame
        activityIndikator.addSubview(imageView)
        activityIndikator.center = view.center
        activityIndikator.backgroundColor = .white
        return activityIndikator
    }
    
    func takeFrame(frame: CGRect) { view.frame = frame}
}
