//
//  ItemMovieCell.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import UIKit
import SnapKit

class ItemMovieCell: UICollectionViewCell {
  
  static let CELL_HEIGHT: CGFloat = 300
  
  lazy var imgPoster: UIImageView = {
    let imgPoster = UIImageView()
    imgPoster.translatesAutoresizingMaskIntoConstraints = false
    imgPoster.layer.masksToBounds = true
    imgPoster.layer.cornerRadius = 8
    imgPoster.contentMode = .scaleAspectFill
    contentView.addSubview(imgPoster)
    return imgPoster
  }()
  
  lazy var lblTitle: UILabel = {
    let lblTitle = UILabel()
    lblTitle.translatesAutoresizingMaskIntoConstraints = false
    lblTitle.textAlignment = .center
    lblTitle.font = UIFont.font(type: .sfSemibold, size: CGFloat.size_20)
    lblTitle.textColor = UIColor.white
    lblTitle.numberOfLines = 2
    contentView.addSubview(lblTitle)
    return lblTitle
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
  }
  
  func configureView(movie: Movie) {
    lblTitle.text = movie.title
    imgPoster.setImageUrl(urlPath: movie.posterURL)
  }
}

extension ItemMovieCell {
  private func setupConstraint() {
    imgPoster.snp.makeConstraints { make in
      make.left.top.right.bottom.equalToSuperview()
    }
    
    lblTitle.snp.makeConstraints { make in
      make.left.equalTo(imgPoster.snp_leftMargin)
      make.right.equalTo(imgPoster.snp_rightMargin)
      make.centerY.equalTo(imgPoster)
    }
  }
}
