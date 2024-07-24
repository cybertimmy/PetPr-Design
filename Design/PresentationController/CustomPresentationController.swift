import UIKit

final class CustomPresentationController: UIPresentationController {

    private var calculatedFrameOfPresentedViewInContainerView = CGRect.zero
    private var shouldSetFrameWhenAccessingPresentedView = false
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 0, y: containerView.bounds.height * 0.4, width: containerView.bounds.width, height: containerView.bounds.height * 0.6)
    }
    
    private lazy var dismissSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        recognizer.direction = .down
        return recognizer
    }()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedViewController.view.addGestureRecognizer(dismissSwipeGestureRecognizer)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        calculatedFrameOfPresentedViewInContainerView = frameOfPresentedViewInContainerView
    }
    
    @objc private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
