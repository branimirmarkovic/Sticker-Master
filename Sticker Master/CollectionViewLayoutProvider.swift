//
//  CollectionViewLayoutProvider.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 30.8.22..
//

import UIKit


protocol CollectionViewLayoutFactory {
    func gridLayout() -> UICollectionViewLayout
}

class DefaultCollectionViewLayoutProvider: CollectionViewLayoutFactory {
    func gridLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.gridSection()
        }
    }

    private func gridSection() -> NSCollectionLayoutSection {

        let itemInsets: CGFloat = 10
        let sectionInsets: CGFloat = 20

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/5),
            heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: itemInsets, leading: itemInsets, bottom: itemInsets, trailing: itemInsets)

        let widhtDimension = NSCollectionLayoutDimension.fractionalWidth(1)
        let heightDimension = NSCollectionLayoutDimension.fractionalWidth(1/5)

        let groupSize = NSCollectionLayoutSize(widthDimension: widhtDimension, heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top: sectionInsets, leading: sectionInsets, bottom: sectionInsets, trailing: sectionInsets)
        return section
    }
}
