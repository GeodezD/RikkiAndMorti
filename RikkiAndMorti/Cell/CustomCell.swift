//
//  CustomCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.06.2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    private let label = UILabel()
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
        //UIImage
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.layer.cornerRadius = 20
        viewImage.clipsToBounds = true
        viewImage.image = image
        
        //UILabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // CustomCell
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(label)
        addSubview(viewImage)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            label.heightAnchor.constraint(equalToConstant: 20),
            viewImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            viewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            viewImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            viewImage.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -4),
        ])
    }
    
    func setName(with text: String) {
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
    }
    
    func setImage(with picture: String) {
        guard let url = URL(string: picture) else { fatalError( "Error" ) }
        GetImage().downloadImage(url: url) { image in
            self.image = image
        }
    }
}
