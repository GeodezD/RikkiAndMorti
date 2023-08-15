//
//  ViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 10.07.2023.
//

import UIKit

class CharacterViewCell: UIViewController {
    
    var indexPathCell: Int?
    private let viewImage = UIImageView()
    private let navigation = UINavigationItem()
    private let navigationBar = UINavigationBar()
    private let generalView = UIView()
    private let myData: CharactersModel = {
        let network = NetworkManager()
        guard let data = network.returnDataFromUserDafaults(into: CharactersModel.self) else { fatalError()}
        return data
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width - 32, height: view.frame.height + 400)
    }
    
    private var image: UIImage? {
        didSet {
            viewImage.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
        setup()
        test()
        setupViewsConstraints()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
   
    private func setup() {
        view.backgroundColor = .white
        
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        navigation.title = "Character"
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(prevPage))
        self.navigation.leftBarButtonItem = back
        
        view.addSubview(generalView)
        view.addSubview(navigationBar)
        generalView.addSubview(viewImage)
        generalView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    @objc func prevPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func test() {
        
        guard let indexPathCell = indexPathCell else { return }
        let data = [
            "NAME:",
            myData.results[indexPathCell].name,
            "STATUS:",
            myData.results[indexPathCell].status,
            "GENDER:",
            myData.results[indexPathCell].gender,
            "SPECIES:",
            myData.results[indexPathCell].species,
            "LOCATION:",
            myData.results[indexPathCell].origin.name,
        ]
        
        for index in 0..<data.count {
            let label = UILabel()
            label.numberOfLines = 3
            label.font = .systemFont(ofSize: 16)
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
            if index % 2 == 0 {
                label.font = .systemFont(ofSize: 20)
                view.backgroundColor = .systemGray4
                label.textAlignment = .center
            } else {
                view.backgroundColor = .white
            }
            label.text = data[index]
            label.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
            view.addSubview(label)
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupViewsConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        generalView.translatesAutoresizingMaskIntoConstraints = false
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor
                                                       , constant: 8),
                navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                navigationBar.heightAnchor.constraint(equalToConstant: 44),
                
                generalView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 4),
                generalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                generalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                generalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                
                viewImage.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 8),
                viewImage.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 8),
                viewImage.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -8),
                viewImage.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -8),
                
                scrollView.topAnchor.constraint(equalTo: viewImage.bottomAnchor, constant: 8),
                scrollView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 8),
                scrollView.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -8),
                scrollView.bottomAnchor.constraint(equalTo: generalView.bottomAnchor, constant: -8),
                
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
            ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 300),
                view.heightAnchor.constraint(equalToConstant: 44),
            ])
        }
    }
    
    private func downloadImage() {
        guard let indexPathCell = indexPathCell else { return }
        let data = myData.results[indexPathCell].image
        DispatchQueue.main.async {
            guard let url = URL(string: data) else { fatalError( "Error" ) }
            GetImage().downloadImage(url: url) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

