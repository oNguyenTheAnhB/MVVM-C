//
//  DetailUserViewCell.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import UIKit

class DetailUserViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ viewModel: DetailUserViewModel) {
        textLabel?.text = viewModel.username
        imageView?.kf.setImage(with: URL(string: viewModel.avatar))
    }
}
