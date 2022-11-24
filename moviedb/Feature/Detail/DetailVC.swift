//
//  DetailVC.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import UIKit
import RxSwift
import Kingfisher

class DetailVC: UIViewController {
  
  @IBOutlet weak var lblRate: UILabel!
  @IBOutlet weak var btnTrailer: UIButton!
  @IBOutlet weak var btnReview: UIButton!
  @IBOutlet weak var lblOverview: UILabel!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var imgBackdrop: UIImageView!
  
  private let disposeBag = DisposeBag()
  private var detailVM: DetailVM!
  private var movieVideo: MovieVideo?
  var movie: Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    detailVM = DetailVM(movieService: MovieService.shared)
    detailVM.fetchVideo(idMovie: movie.id)
    
    configureView()
    fetchingData()
  }
  
  @IBAction func didTapTrailer(_ sender: Any) {
    UIApplication.shared.open((movieVideo?.youtubeURL)!)
  }
  
  @IBAction func didTapReview(_ sender: Any) {
    let vc = ReviewVC()
    vc.movie = movie
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func configureView() {
    lblTitle.text = movie?.title
    lblOverview.text = movie?.overview
    imgBackdrop.kf.setImage(with: movie?.backdropURL)
    lblRate.text = String().rating(vote: movie.voteAverage)
  }
  
  private func fetchingData() {
    detailVM.video.drive(onNext: {[weak self] video in
      guard let self = self else {return}
      
      let _ = video.map({ video in
        if video.type == "Trailer" {
          self.movieVideo = video
          let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
          self.btnTrailer.kf.setImage(with: video.youtubeTumbnail, for: .normal, options: [.imageModifier(modifier)])
        }
      })
    }).disposed(by: disposeBag)
  }
}
