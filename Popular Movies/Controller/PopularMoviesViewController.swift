//
//  ViewController.swift
//  Popular Movies
//
//  Created by Berkay Demir on 22.08.2024.
//

import UIKit

class PopularMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let popularMoviesVM = PopularMoviesViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPopularMovies()
    }
    
    private func loadPopularMovies() {
        popularMoviesVM.getPopularMovies { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMoviesVM.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopularMoviesTableViewCell else { return UITableViewCell()
        }
        
        let movie = popularMoviesVM.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
        
        
    }


}

