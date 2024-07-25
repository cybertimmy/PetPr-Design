import Foundation
import UIKit

final class Collection {
    static func createSection(itemWidth: NSCollectionLayoutDimension,
                               itemHeight: NSCollectionLayoutDimension,
                               interItemSpacing: Double = 0,
                               groupWidth: NSCollectionLayoutDimension,
                               groupHeight:NSCollectionLayoutDimension,
                               interGroupSpacing: Double = 0,
                               headerHight: NSCollectionLayoutDimension? = nil,
                               sectionInsets: NSDirectionalEdgeInsets = .zero,
                               scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth,
                                              heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(interItemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        section.interGroupSpacing = interGroupSpacing
        section.contentInsets = sectionInsets
        section.boundarySupplementaryItems = []
               if let headerHight = headerHight {
                   let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: headerHight)
                   let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: HeaderCollectionReusableView.description(), alignment: .top)
                   section.boundarySupplementaryItems.append(header)
               }
               return section
    }
    
    static func emptySection(height: CGFloat = 0) -> NSCollectionLayoutSection {
        return Collection.createSection(itemWidth: .fractionalWidth(1),
                             itemHeight: .absolute(height),
                             groupWidth: .fractionalWidth(1),
                             groupHeight: .absolute(1))
    }
}
