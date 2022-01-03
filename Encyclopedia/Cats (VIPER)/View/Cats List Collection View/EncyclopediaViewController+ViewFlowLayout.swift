//
//  EncyclopediaViewController+ViewFlowLayout.swift
//  Encyclopedia
//
//  Created by  on 03/01/2022.
//

import UIKit

extension EncyclopediaViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimunLineSpacingForCollectionView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
