//
//  ImageTestCollectionViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

class ImageTestCollectionViewCell: UICollectionViewCell {
    
    private var viewImage = UIImageView()
    private var image: UIImage? {
        didSet {
            viewImage.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        viewImage.layer.cornerRadius = 20
        viewImage.clipsToBounds = true
        viewImage.image = image
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        
        addSubview(viewImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            viewImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            viewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            viewImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            viewImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
    }
    
    func setImage(with picture: String) {
        guard let url = URL(string: picture) else { fatalError( "Error" ) }
        GetImage().downloadImage(url: url) { image in
            self.image = image
        }
    }
}
