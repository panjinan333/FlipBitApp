//
//  FinanceNewsRowAdapter.swift
//  FinanceApp
//
//  Created by Florian Marcu on 3/16/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class FinanceNewsRowAdapter: GenericCollectionRowAdapter {
    var uiConfig: UIGenericConfigurationProtocol
    init(uiConfig: UIGenericConfigurationProtocol) {
        self.uiConfig = uiConfig
    }

    func configure(cell: UICollectionViewCell, with object: GenericBaseModel) {
        if let news = object as? FinanceNewsModel, let cell = cell as? FinanceNewsCollectionViewCell {
            cell.newsTitleLabel.text = news.title
            cell.newsTitleLabel.textColor = uiConfig.mainTextColor
            cell.newsTitleLabel.font = uiConfig.boldFont(size: 18)

            cell.newsSubtitleLabel.text = news.subtitle
            cell.newsSubtitleLabel.textColor = uiConfig.mainSubtextColor
            cell.newsSubtitleLabel.font = uiConfig.regularFont(size: 12)

            cell.bottomBorderView.backgroundColor = uiConfig.hairlineColor
            cell.containerView.backgroundColor = uiConfig.mainThemeBackgroundColor
            cell.backgroundColor = uiConfig.mainThemeBackgroundColor
        }
    }

    func cellClass() -> UICollectionViewCell.Type {
        return FinanceNewsCollectionViewCell.self
    }

    func size(containerBounds: CGRect, object: GenericBaseModel) -> CGSize {
        guard let viewModel = object as? FinanceNewsModel else { return .zero }
        return CGSize(width: containerBounds.width, height: 100)
    }
}
