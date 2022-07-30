//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 19/06/22.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    var titles: [Title] = [Title]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CollectionViewTableViewCell.identifier)
        
        contentView.backgroundColor = .systemBrown
        contentView.addSubview(collectionView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = titles[indexPath.row].poster_path else {return UICollectionViewCell()}
        
        cell.configure(with: model)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_name ?? title.original_title else {return}
        
        APICaller.shared.getMovie(with: titleName + " trailer") { result in
            switch result {
            case .success(let videoElement):
                print(videoElement)
            case .failure(let error):
                print(error)
            }
        }
        
                
    }
}
