//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 24/07/22.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    private let playButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let downloadButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.image = UIImage(named: "heroImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func addGradient() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradient.frame = bounds
        
        layer.addSublayer(gradient)
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(heroImageView)
        
        addGradient()
        
        addSubview(playButton)
        addSubview(downloadButton)
        
        
        applyConstrainsts()
        
    }
    
    public func configure(with model: Title?) {
        guard let model = model else {return}
        guard let path = model.poster_path else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") else {return}
        heroImageView.sd_setImage(with: url)
        
    }
    
    private func applyConstrainsts() {
        
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let heroImageViewConstraints = [
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.topAnchor.constraint(equalTo: topAnchor, constant: 26)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(heroImageViewConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
