//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 18/06/22.
//

import UIKit

enum Sections: Int {
    
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTv = 2
    case UpcomingMovies = 3
    case TopRated = 4
    
}

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    let sectionTitles = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    
    private var headerViewTitle: Title?
    private var heroView: HeroHeaderUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable) //add ui table view
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        heroView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = heroView
        
        getRandomHeaderTitle()
        
    }
    
    private func getRandomHeaderTitle() {
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result {
            case .success(let titles):
                self?.headerViewTitle = titles.randomElement()
                self?.heroView?.configure(with: self?.headerViewTitle)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureNavBar()  {
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal).resizeTo(size: CGSize(width: 18, height: 30))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image , style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var scrollOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -scrollOffset))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
                switch results{
                case.success(let movies):
                    cell.configure(with: movies)
                    
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.getTrendingTvs { results in
                switch results {
                case .success(let res):
                    cell.configure(with: res)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { results in
                switch results {
                case .success(let res):
                    cell.configure(with: res)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopularMovies { results in
                switch results {
                case .success(let res):
                    cell.configure(with: res)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.UpcomingMovies.rawValue:
            
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success(let res):
                    cell.configure(with: res)
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = UIColor.white

        
        
    }
    
}


extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}
