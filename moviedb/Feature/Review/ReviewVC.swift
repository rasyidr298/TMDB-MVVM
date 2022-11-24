//
//  ReviewVC.swift
//  moviedb
//
//  Created by Rasyid Ridla on 24/11/22.
//

import UIKit
import RxSwift

class ReviewVC: UIViewController {
  
  @IBOutlet weak var lblInfo: UILabel!
  @IBOutlet weak var actIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tblReview: UITableView!
  
  private let disposeBag = DisposeBag()
  private var reviewVM: ReviewVM!
  private var reviews = [MovieReview]()
  var movie: Movie!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    reviewVM = ReviewVM(movieService: MovieService.shared)
    reviewVM.fetchReview(idMovie: movie.id)
    
    configureView()
    fetchingData()
  }
  
  private func configureView() {
    title = "Review"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tblReview.delegate = self
    tblReview.dataSource = self
    tblReview.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
  }
  
  private func fetchingData() {
    reviewVM.reviews.drive(onNext: {[weak self] reviews in
      guard let self = self else {return}
      
      self.lblInfo.isHidden = !self.reviewVM.isEmpty
      if self.reviewVM.isEmpty {
        self.lblInfo.text = "nil"
      }
      self.reviews = reviews
      self.tblReview.reloadData()
    }).disposed(by: disposeBag)
    
    reviewVM.isFetching.drive(actIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    reviewVM.error.drive(onNext: {[weak self] error in
      guard let self = self else {return}
      
      self.lblInfo.isHidden = !self.reviewVM.hasError
      self.lblInfo.text = error
    }).disposed(by: disposeBag)
  }
}

extension ReviewVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviewVM.numberOfReview
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
    cell.configure(review: reviews[indexPath.row])
    return cell
  }
}
