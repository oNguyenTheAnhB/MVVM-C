//
//  ListViewCell.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import UIKit
import Kingfisher

class ListViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var otherInfoLabel: UILabel!

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ viewModel: ListItemViewModel) {
        avatarImageView.kf.setImage(with: URL(string: viewModel.avatar))
        repositoryNameLabel.text = viewModel.name
        repositoryDescriptionLabel.text = viewModel.summary
        otherInfoLabel.text = viewModel.other
    }
}
