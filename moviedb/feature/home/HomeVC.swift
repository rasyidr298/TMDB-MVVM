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
  @IBOutlet weak var clvMovie: UICollectionView!
  
  private let disposeBag = DisposeBag()
  private var homeVM: HomeVM!
  private var movies = [Movie]()
  private var curentPage = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
    fetchingData()
  }
  
  // MARK: Configure View
  private func configureView() {
    title = "Movies"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    homeVM = HomeVM()
    homeVM.fetchPopularMovies(page: curentPage)
    
    self.clvMovie.delegate = self
    self.clvMovie.dataSource = self
    self.clvMovie.register(cell: ItemMovieCell.self)
  }
  
  // MARK: Fetching Data
  private func fetchingData() {
    homeVM.popularMovies.subscribe(onNext: { [weak self] state in
      guard let self = self else {return}
      switch state.simplify() {
      case .loading:
        self.actIndicator.start()
      case .success(let data):
        self.movies.append(contentsOf: data)
        self.clvMovie.reloadData()
        self.actIndicator.stop()
      case .error(let error):
        self.showGeneralError(message: error.localizedDescription)
        self.actIndicator.stop()
      default:
        break
      }
    }).disposed(by: disposeBag)
  }
}

// MARK: Configure CollectionView
extension HomeVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(for: indexPath) as ItemMovieCell
    cell.configureView(movie: movies[indexPath.row])
    
    if indexPath.row == movies.count - 1 {
      curentPage += 1
      homeVM.fetchPopularMovies(page: curentPage)
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let navigationController = navigationController {
      let vc = DetailVC()
      vc.movie = self.movies[indexPath.row]
      navigationController.pushViewController(vc, animated: true)
    }
  }
}

// MARK: Configure CollectionViewLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 2
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemWidth = view.bounds.width / 2
    return CGSize(width: itemWidth - 2 , height: ItemMovieCell.CELL_HEIGHT )
  }
}
