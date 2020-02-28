//
//  MagazineCollectionView.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit
import MagazineLayout
import RxCocoa

class MagazineCollectionView: UICollectionView { }

fileprivate let collectionViewDelegateNotSet = MagazineLayoutDelegateNotSet()

final private class MagazineLayoutDelegateNotSet: NSObject, UICollectionViewDelegateMagazineLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        return .init(widthMode: .fullWidth(respectsHorizontalInsets: true), heightMode: .dynamic)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return MagazineLayoutHeaderVisibilityMode.hidden
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        return MagazineLayoutFooterVisibilityMode.hidden
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return MagazineLayoutBackgroundVisibilityMode.hidden
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return .zero
    }
    
}

class MagazineLayoutDelegateProxy: RxCollectionViewDelegateProxy, UICollectionViewDelegateMagazineLayout {
    
    public weak private(set) var magazineCollectionView: MagazineCollectionView?
    
    init(collectionView: MagazineCollectionView) {
        self.magazineCollectionView = collectionView
        super.init(collectionView: collectionView)
    }
    
    public static func registerImplementation() {
        self.register { MagazineLayoutDelegateProxy(collectionView: $0) }
    }
    
    private weak var _requiredMethodsDelegate: UICollectionViewDelegateMagazineLayout? = collectionViewDelegateNotSet
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         sizeModeForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         visibilityModeForHeaderInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         visibilityModeForFooterInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         visibilityModeForBackgroundInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         horizontalSpacingForItemsInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         verticalSpacingForElementsInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         insetsForItemsInSectionAtIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return (_requiredMethodsDelegate ?? collectionViewDelegateNotSet).collectionView(collectionView,
                                                                                         layout: collectionViewLayout,
                                                                                         insetsForSectionAtIndex: index)
    }
    
    override func setForwardToDelegate(_ delegate: UIScrollViewDelegate?, retainDelegate: Bool) {
        _requiredMethodsDelegate = (delegate as? UICollectionViewDelegateMagazineLayout) ?? collectionViewDelegateNotSet
        super.setForwardToDelegate(delegate, retainDelegate: retainDelegate)
    }
    
}
