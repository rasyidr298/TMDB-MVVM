//
//  ItemReviewCell.swift
//  moviedb
//
//  Created by Rasyid Ridla on 29/01/23.
//

import UIKit
import SnapKit

class ItemReviewCell: UITableViewCell {
  
  lazy var imgAvatar: UIImageView = {
    let imgAvatar = UIImageView()
    imgAvatar.contentMode = .scaleAspectFill
    contentView.addSubview(imgAvatar)
    return imgAvatar
  }()
  
  lazy var lblAuthor: UILabel = {
    let lblAuthor = UILabel()
    lblAuthor.font = UIFont.font(type: .sfSemibold, size: CGFloat.size_18)
    lblAuthor.numberOfLines = 1
    contentView.addSubview(lblAuthor)
    return lblAuthor
  }()
  
  lazy var lblContent: UILabel = {
    let lblContent = UILabel()
    lblContent.font = UIFont.font(type: .sfRegular, size: CGFloat.size_12)
    lblContent.numberOfLines = 500
    contentView.addSubview(lblContent)
    return lblContent
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView(review: MovieReview) {
    lblAuthor.text = review.author
    lblContent.text = review.content
    imgAvatar.setImageUrl(urlPath: (review.avatarPath ?? review.authorDetails.avatarPathUrl) ?? "")
  }
}

extension ItemReviewCell {
  private func setupConstraint() {
    imgAvatar.snp.makeConstraints { make in
      make.height.width.equalTo(20)
      make.top.left.equalToSuperview().offset(8)
    }
    
    lblAuthor.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.left.equalTo(imgAvatar.snp_rightMargin).offset(12)
      make.right.equalToSuperview().offset(8)
    }
    
    lblContent.snp.makeConstraints { make in
      make.top.equalTo(lblAuthor.snp_bottomMargin).offset(8)
      make.bottom.equalToSuperview().offset(8)
      make.left.right.equalToSuperview().inset(12)
    }
  }
}
