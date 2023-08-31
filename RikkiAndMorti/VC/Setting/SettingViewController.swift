//
//  SettingViewController.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 11.08.2023.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let clearCache = UIButton(configuration: .filled())
    private let textClearCache = UILabel()
    
    private let switchMotherDesigner = UISwitch()
    private let labelMotherDesigner = UILabel()
    
    private let viewMotherDesigner = UIView()
    
    private let labelColorBackground = UILabel()
    private let labelColorCell = UILabel()
     let viewColorBackground = UIView()
    var setColor = UIColor.systemGray3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        test()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    func setup() {
        clearCache.setTitle("Clear", for: .normal)
        clearCache.addAction(UIAction { _ in
            let cache = GetImage()
            cache.clearCache()
            print("Cache clear")
        }, for: .touchUpInside)
        
        textClearCache.text = "Clear cache"
        textClearCache.sizeToFit()
        
        labelMotherDesigner.text = "Activate mode: \"Mother designer\" "
        switchMotherDesigner.addTarget(self, action: #selector(setupSwitchMotherDesigner), for: .valueChanged)
        
        labelColorBackground.text = "Set color background"
        viewColorBackground.backgroundColor = .systemGray4
        
        view.addSubview(textClearCache)
        view.addSubview(clearCache)
        
        view.addSubview(labelMotherDesigner)
        view.addSubview(switchMotherDesigner)
        
        view.addSubview(viewMotherDesigner)
        viewMotherDesigner.addSubview(labelColorBackground)
        viewMotherDesigner.addSubview(viewColorBackground)
    }
    
    func test() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewColorBackground.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {

        let pickerViewController = UIColorPickerViewController()
            pickerViewController.selectedColor = setColor
            pickerViewController.delegate = self
            present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc func setupSwitchMotherDesigner() {
        if switchMotherDesigner.isOn {

        } else {
            
        }
    }
    
    func setupConstraints() {
        textClearCache.translatesAutoresizingMaskIntoConstraints = false
        clearCache.translatesAutoresizingMaskIntoConstraints = false
        
        labelMotherDesigner.translatesAutoresizingMaskIntoConstraints = false
        switchMotherDesigner.translatesAutoresizingMaskIntoConstraints = false
        
        viewMotherDesigner.translatesAutoresizingMaskIntoConstraints = false
        viewColorBackground.translatesAutoresizingMaskIntoConstraints = false
        labelColorBackground.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textClearCache.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            textClearCache.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            textClearCache.trailingAnchor.constraint(equalTo: clearCache.leadingAnchor, constant: -4),
            textClearCache.heightAnchor.constraint(equalToConstant: 44),
            
            clearCache.leadingAnchor.constraint(equalTo: textClearCache.trailingAnchor, constant: 4),
            clearCache.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            clearCache.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            clearCache.heightAnchor.constraint(equalToConstant: 44),
            
            labelMotherDesigner.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            labelMotherDesigner.topAnchor.constraint(equalTo: textClearCache.bottomAnchor, constant: 16),
            labelMotherDesigner.trailingAnchor.constraint(equalTo: switchMotherDesigner.leadingAnchor, constant: -4),
            labelMotherDesigner.heightAnchor.constraint(equalToConstant: 44),
            
            switchMotherDesigner.leadingAnchor.constraint(equalTo: labelMotherDesigner.trailingAnchor, constant: 4),
            switchMotherDesigner.topAnchor.constraint(equalTo: clearCache.bottomAnchor, constant: 16),
            switchMotherDesigner.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            switchMotherDesigner.heightAnchor.constraint(equalToConstant: 44),
            
            viewMotherDesigner.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            viewMotherDesigner.topAnchor.constraint(equalTo: switchMotherDesigner.bottomAnchor, constant: 8),
            viewMotherDesigner.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            viewMotherDesigner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            labelColorBackground.leadingAnchor.constraint(equalTo: viewMotherDesigner.leadingAnchor, constant: 0),
            labelColorBackground.topAnchor.constraint(equalTo: viewMotherDesigner.topAnchor, constant: 0),
            labelColorBackground.trailingAnchor.constraint(equalTo: viewColorBackground.leadingAnchor, constant: -8),
            labelColorBackground.heightAnchor.constraint(equalToConstant: 44),
            
            viewColorBackground.trailingAnchor.constraint(equalTo: viewMotherDesigner.trailingAnchor, constant: -2),
            viewColorBackground.topAnchor.constraint(equalTo: viewMotherDesigner.topAnchor, constant: 2),
            viewColorBackground.widthAnchor.constraint(equalToConstant: 44),
            viewColorBackground.heightAnchor.constraint(equalToConstant: 44),
            
            
        ])
    }
}
