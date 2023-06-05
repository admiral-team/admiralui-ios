//
//  IconsViewController.swift
//  Example iOS
//
//  Created on 13.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralImages
import UIKit

class ImageSectionViewModel {
    var title: String
    var icons: [AdmiralImages.ImageAsset]
    var size: CGSize
    
    init(title: String,
         icons: [AdmiralImages.ImageAsset],
         size: CGSize) {
        self.title = title
        self.icons = icons
        self.size = size
    }
}

final class IconsViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellIdentifier = "cell"
        static let headerIdentifier = "header"
        static let outlineKey = "Outline"
        static let solidKey = "Solid"
    }
    
    // MARK: - Private Properties
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = false
        collection.backgroundColor = .white
        collection.contentInset.bottom = LayoutGrid.module * 7
        return collection
    }()
    
    private let searchBar = SearchBar()
    private let segmentControl = StandardSegmentedControl(frame: .zero)
    private var outlineImageSections: [ImageSectionViewModel] = []
    private var solidImageSections: [ImageSectionViewModel] = []
    private var searchOutlineImageSections: [ImageSectionViewModel] = []
    private var searchSolidImageSections: [ImageSectionViewModel] = []
    private var informer = SmallInformer()
    private let themeSwitchView = ThemeSwitchView()
    private var isSearching: Bool = false {
        didSet { collectionView.reloadData() }
    }
    private var isThemeSwitchButtonHidden = false
    
    private var dataSource = [ImageSectionViewModel]() {
        didSet { collectionView.reloadData() }
    }
    private var theme: AppTheme?
        
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSegment()
        configureSeacrhBar()
        configureCollectionView()
        configureConstraints()
        configureDataSource()
        hideInformerWhenTappedAround()
        addThemeSwitchView(themeSwitchView)
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        self.theme = theme
        segmentControl.apply(theme: theme)
        searchBar.apply(theme: theme)
        informer.apply(theme: theme)
        collectionView.backgroundColor = theme.colors.backgroundBasic.uiColor
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        [collectionView,
         segmentControl,
         searchBar].addToSuperview(view)
    }
    
    private func configureDataSource() {
        for image in AdmiralImages.Asset.allImages {
            let title = nameSectionTitle(image.name)

            if image.name.contains(Constants.outlineKey) {
                if let indexSection = outlineImageSections.firstIndex(where: { $0.title == title }) {
                    outlineImageSections[indexSection].icons.append(image)
                } else {
                    outlineImageSections.append(ImageSectionViewModel(title: title, icons: [image], size: image.image.size))
                }
            } else {
                if let indexSection = solidImageSections.firstIndex(where: { $0.title == title }) {
                    solidImageSections[indexSection].icons.append(image)
                } else {
                    solidImageSections.append(ImageSectionViewModel(title: title, icons: [image], size: image.image.size))
                }
            }
        }

        outlineImageSections.sort { sectionFirst, sectionSecond -> Bool in
            (sectionFirst.size.width * sectionFirst.size.height) < (sectionSecond.size.width * sectionSecond.size.height)
        }
        
        solidImageSections.sort { sectionFirst, sectionSecond -> Bool in
            (sectionFirst.size.width * sectionFirst.size.height) < (sectionSecond.size.width * sectionSecond.size.height)
        }
        
        dataSource = outlineImageSections
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.headerIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
    }
    
    private func configureSeacrhBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
    }
    
    private func configureSegment() {
        segmentControl.setItems([
            StandardSegmentedItem(title: "Outline", accesibilityId: "SegmentControlOutline"),
            StandardSegmentedItem(title: "Solid", accesibilityId: "SegmentControlSolid")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func nameSectionTitle(_ assetName: String) -> String {
        let array = assetName.components(separatedBy: "/")
        return array.first ?? assetName
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.doubleModule),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.module),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.module),
            segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: LayoutGrid.module),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule)
        ])
    }
    
    private func filterData(text: String) {
        searchOutlineImageSections.removeAll()
        searchSolidImageSections.removeAll()
        
        defer {
            searchOutlineImageSections.sort { sectionFirst, sectionSecond -> Bool in
                (sectionFirst.size.width * sectionFirst.size.height) < (sectionSecond.size.width * sectionSecond.size.height)
            }

            searchSolidImageSections.sort { sectionFirst, sectionSecond -> Bool in
                (sectionFirst.size.width * sectionFirst.size.height) < (sectionSecond.size.width * sectionSecond.size.height)
            }

            dataSource = segmentControl.selectedSegmentIndex == 0 ? searchOutlineImageSections : searchSolidImageSections
        }

        for image in AdmiralImages.Asset.allImages {
            let title = nameSectionTitle(image.name)

            guard image.name.lowercased().contains(text.lowercased().replacingOccurrences(of: " ", with: "")) else { continue }

            if image.name.contains(Constants.outlineKey) {
                if let indexSection = searchOutlineImageSections.firstIndex(where: { $0.title == title }) {
                    searchOutlineImageSections[indexSection].icons.append(image)
                } else {
                    searchOutlineImageSections.append(ImageSectionViewModel(title: title, icons: [image], size: image.image.size))
                }
            } else {
                if let indexSection = searchSolidImageSections.firstIndex(where: { $0.title == title }) {
                    searchSolidImageSections[indexSection].icons.append(image)
                } else {
                    searchSolidImageSections.append(ImageSectionViewModel(title: title, icons: [image], size: image.image.size))
                }
            }
        }
    }
    
    private func getOriginalName(_ text: String?) -> String? {
        guard let text = text else { return nil }
        
        var filterText = text
        filterText = filterText
            .replacingOccurrences(of: Constants.outlineKey, with: "")
            .replacingOccurrences(of: Constants.solidKey, with: "")
        
        let filterStringArray = splitYourString(filterText).map { $0.capitalized }
        let joinedText = filterStringArray.joined(separator: " ")
        
        return joinedText
    }
    
    private func splitYourString(_ s: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: "([a-z]*)([A-Z])") else { return [] }
        
        return regex.stringByReplacingMatches(
            in: s, range: NSRange(0..<s.utf16.count),
            withTemplate: "$1 $2").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
    }
    
    private func hideInformerWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissInformer))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissInformer() {
        informer.removeFromSuperview()
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        if isSearching {
            dataSource = control.selectedSegmentIndex == 0 ? searchOutlineImageSections : searchSolidImageSections
        } else {
            dataSource = control.selectedSegmentIndex == 0 ? outlineImageSections : solidImageSections
        }
    }
    
   
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension IconsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6
        return CGSize(width: width, height: LayoutGrid.halfModule * 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 64.0)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as? SectionHeader {

            sectionHeader.configure(viewModel: SectionHeaderViewModel(title: dataSource[indexPath.section].title))
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 12, bottom: 16, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        informer.removeFromSuperview()
        let imageAsset = dataSource[indexPath.section].icons[indexPath.row]
        
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell,
            let title = getOriginalName(imageAsset.name.components(separatedBy: "/").last),
            let font = informer.titleFont,
            let theme = theme
        else { return }
        
        let cellCenter = collectionView.convert(cell.center, to: collectionView.superview)
        let size = title.size(withAttributes: [.font: font])
        
        if cellCenter.x < collectionView.frame.maxX / 2 {
            informer = SmallInformer(
                frame: .init(
                    x: cellCenter.x - LayoutGrid.tripleModule,
                    y: cellCenter.y,
                    width: size.width + LayoutGrid.halfModule * 7,
                    height: LayoutGrid.halfModule * 14))
            informer.style = .default
            informer.titleText = title
            informer.setArrowPivotLeadingAnchorPoint(constant: LayoutGrid.halfModule * 4)
            informer.apply(theme: theme)
            view.addSubview(informer)
        } else {
            informer = SmallInformer(
                frame: .init(
                    x: cellCenter.x - size.width,
                    y: cellCenter.y,
                    width: size.width + LayoutGrid.halfModule * 7,
                    height: LayoutGrid.halfModule * 14))
            informer.style = .default
            informer.titleText = title
            informer.setArrowPivotLeadingAnchorPoint(constant: informer.frame.width - LayoutGrid.module * 4)
            informer.apply(theme: theme)
            view.addSubview(informer)
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        informer.removeFromSuperview()
    }
    
}

// MARK: - UICollectionViewDataSource

extension IconsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource[section].icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? IconCell else {
            fatalError("Couldn't cast cell to IconCell")
        }
  
        let imageAsset = dataSource[indexPath.section].icons[indexPath.row]
        let title = getOriginalName(imageAsset.name.components(separatedBy: "/").last) ?? ""
        cell.configure(viewModel: IconCellViewModel(image: imageAsset.image, title: title))
        
        return cell
    }
    
    private func nameImageTitle(_ assetName: String) -> String {
        let array = assetName.components(separatedBy: "/")
        if array.count > 2 {
            return array[2]
        }
        
        return assetName
    }
    
    @objc private func tapThemeSwitchButton(_ button: UIButton) {
        themeSwitchView.setIsHidden(!button.isSelected, animated: true)
        
        if !themeSwitchView.isHidden {
            themeSwitchView.reloadData()
        }
    }
    
}

// MARK: - UISearchBarDelegate

extension IconsViewController: SearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: SearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: SearchBar, textDidChange searchText: String) {
        informer.removeFromSuperview()
        if searchText.isEmpty {
            isSearching = false
            dataSource = segmentControl.selectedSegmentIndex == 0 ? outlineImageSections : solidImageSections
        } else {
            filterData(text: searchText)
            isSearching = true
        }
    }
    
}
