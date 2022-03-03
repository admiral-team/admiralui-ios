//
//  OnboardingPageViewController.swift
//  ExampleiOS
//
//  Created on 29.03.2021.
//

import AdmiralTheme
import AdmiralUIKit
import UIKit

class OnboardingPageViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var onboardingPageModels = [OnboardingPageModel]()
    
    // MARK: - Private Properties
    
    private var currentIndex = 0 {
        didSet {
            circlePageControl.setPage(currentIndex + 1, animated: true)
            leftButton.isHidden = currentIndex == 0
        }
    }
    private var viewOnboardingControllers = [UIViewController]()
    private let circlePageControl = CirclePageControl()
    private var pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private var userSettingService: UserSettingServiceProtocol = UserSettingService()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(Asset.Navigation.arrowLeft.image, for: .normal)
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    private lazy var leftBarButton: UIBarButtonItem = {
       return UIBarButtonItem(customView: leftButton)
    }()
    private lazy var rightBarButton: UIBarButtonItem = {
       return UIBarButtonItem(
        title: "Пропустить",
        style: .plain,
        target: self,
        action: #selector(tapExit))
    }()
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        circlePageControl.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        
        leftButton.tintColor = theme.colors.elementAccent.uiColor
        leftBarButton.tintColor = theme.colors.elementAccent.uiColor
        rightBarButton.tintColor = theme.colors.elementAccent.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
    
        configureNaibgationBar()
        configureViewController()
        addSubviews()
        configureConstraints()
        configureCirclePageControl()
    }
    
    private func configureViewController() {
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        
        for model in onboardingPageModels {
            let vc = OnboardingViewController()
            vc.configure(model: model)
            viewOnboardingControllers.append(vc)
        }
        
        if let firstVC = viewOnboardingControllers.first {
            pageController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func addSubviews() {
        [circlePageControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureCirclePageControl() {
        circlePageControl.delegate = self
        circlePageControl.duration = 0.3
        circlePageControl.totalPages = onboardingPageModels.count
        circlePageControl.currentPage = 1
        circlePageControl.setPage(1, animated: true)
    }
    
    private func configureNaibgationBar() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func tapExit() {
        finish()
    }
    
    @objc private func tapBack() {
        goToPreviousPage()
    }
    
    private func finish() {
        userSettingService.setOnboardingFinish()
        RootRouter().setRoot()
    }
    
    private func goToNextPage() {
        guard let currentViewController = pageController.viewControllers?.first else { return }
        guard let nextViewController = pageController.dataSource?.pageViewController(
                pageController,
                viewControllerAfter: currentViewController ) else {
            finish()
            return
        }
        
        pageController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        
        guard let index = viewOnboardingControllers.firstIndex(of: nextViewController) else { return }
        currentIndex = index
    }
    
    private func goToPreviousPage() {
        guard let currentViewController = pageController.viewControllers?.first else { return }
        guard let previousViewController = pageController.dataSource?.pageViewController(
                pageController,
                viewControllerBefore: currentViewController ) else { return }
        pageController.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
        
        guard let index = viewOnboardingControllers.firstIndex(of: previousViewController) else { return }
        currentIndex = index
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            circlePageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circlePageControl.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 9),
            circlePageControl.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 9)
        ])
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: circlePageControl.bottomAnchor, constant: LayoutGrid.module * 11)
        ])
    }
    
}

// MARK: - CirclePageControlDelegate

extension OnboardingPageViewController: CirclePageControlDelegate {
    
    func didTapCenterButton() {
        goToNextPage()
    }
    
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewOnboardingControllers.firstIndex(of: viewController) else { return nil }
        guard index - 1 >= 0 else { return nil }
        
        return viewOnboardingControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewOnboardingControllers.firstIndex(of: viewController) else { return nil }
        guard viewOnboardingControllers.count > index + 1 else { return nil }
        
        return viewOnboardingControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageController.viewControllers?.first,
              let index = viewOnboardingControllers.firstIndex(of: currentViewController)
              else { return }
        
        currentIndex = index
    }
    
}
