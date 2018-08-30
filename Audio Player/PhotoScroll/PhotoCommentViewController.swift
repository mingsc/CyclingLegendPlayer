//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by neal on 2017/6/29.
//  Copyright © 2017年 Cloudoc. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    public var photoName: String!
    public var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let photoName = photoName {
            imageView.image = UIImage(named: photoName)
        }
        
        let generalTapGesture = UITapGestureRecognizer(target: self, action: Selector.generalTap)
        view.addGestureRecognizer(generalTapGesture)
        
        let zoomTapGesture = UITapGestureRecognizer(target: self, action: Selector.zoomTap)
        imageView.addGestureRecognizer(zoomTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillShowHander, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillHideHander, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification:Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: Notification) {
        adjustInsetForKeyboard(isShow: true, notification: notification)
    }
    
    func keyboardWillHide(notification: Notification) {
        adjustInsetForKeyboard(isShow: false, notification: notification)
    }
    
    func openZoomController(sender: Any?) {
        performSegue(withIdentifier: "zooming", sender: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let id = segue.identifier,
            let zoomingPhotoViewController = segue.destination as? ZoomPhotoViewController
        {
            if id == "zooming" {
                zoomingPhotoViewController.photoName = photoName
            }
        }
    }

}

extension Selector {
    
    static let keyboardWillShowHander = #selector(PhotoCommentViewController.keyboardWillShow(notification:))
    
    static let keyboardWillHideHander = #selector(PhotoCommentViewController.keyboardWillHide(notification:))
    
    static let generalTap = #selector(PhotoCommentViewController.dismissKeyBoard)
    
    static let zoomTap = #selector(PhotoCommentViewController.openZoomController(sender:))
}
