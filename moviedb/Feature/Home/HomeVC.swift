//
//  HomeVC.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import UIKit
import RxSwift

class HomeVC: UIViewController {
  
  @IBOutlet weak var actIndicator: UIActivityIndicatorView!
  @IBOutlet weak var lblInfo: UILabel!
  @IBOutlet weak var clvMovie: UICollectionView!
  
  private let disposeBag = DisposeBag()
  private var homeVM: HomeVM!
  private var movies = [Movie]()
  private var curentPage = 1
  
  private var numberOfItemsInRow = 2
  private var minimumSpacing = 0
  private var edgeInsetPadding = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    homeVM = HomeVM(movieService: MovieService.shared)
    homeVM.fetchMovies(page: curentPage)
    
    configureView()
    fetchingData()
  }
  
  private func configureView() {
    title = "Movies"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    self.clvMovie.delegate = self
    self.clvMovie.dataSource = self
    self.clvMovie.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
  }
  
  private func fetchingData() {
    homeVM.movies.drive(onNext: {[weak self] movies in
      guard let self = self else {return}
      
      self.movies += movies
      self.clvMovie.reloadData()
    }).disposed(by: disposeBag)
    
    homeVM.isFetching.drive(actIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    homeVM.error.drive(onNext: {[weak self] error in
      guard let self = self else {return}
      
      self.lblInfo.isHidden = !self.homeVM.hasError
      self.lblInfo.text = error
    }).disposed(by: disposeBag)
  }
}

extension HomeVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
    cell.configure(movie: movies[indexPath.row])
    
    if indexPath.row == movies.count - 1 {
      curentPage += 1
      homeVM.fetchMovies(page: curentPage)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = DetailVC()
    vc.movie = movies[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(minimumSpacing)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(minimumSpacing)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    edgeInsetPadding = Int(inset.left+inset.right)
    return inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * minimumSpacing - edgeInsetPadding) / numberOfItemsInRow
    return CGSize(width: width, height: width)
  }
}
