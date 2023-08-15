//
//  LocationCharacter.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class Location: UIViewController {
    
    let newView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        let width: CGFloat = 400
        let height: CGFloat = 400
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0,
                                  y: 0,
                                  width: width,
                                  height: height)
        let path = CGMutablePath()
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100),
                               transform: &transform)
            path.addPath(petal)
        }
            
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        view.layer.addSublayer(shapeLayer)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        setupPosition()
    }
    
    func setup() {
        newView.backgroundColor = .green
        newView.layer.cornerRadius = 30
        view.addSubview(newView)
    }
    
    func setupPosition() {
        newView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            newView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            newView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            newView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
}
