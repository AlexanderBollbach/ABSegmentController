import UIKit

protocol ABSegmentProtocol {
   func didTap(segment: ABSegment)
}

class ABSegment: UIView {
   
   let titleLabel = UILabel()
   
   var delegate: ABSegmentProtocol?
   
   // Computed property to allow title to be changed
   var title: String {
      set {
         titleLabel.text = newValue
      }
      get {
         return titleLabel.text ?? ""
      }
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setupLabel(title: "")
   }
   
   convenience init(title: String) {
      
      self.init(frame: CGRect.zero)
      
      self.title = title
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
      addGestureRecognizer(tap)
   }
   
   // This init is called if your view is
   // set up in the Storyboard
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      setupLabel(title: "")
   }
   
   func setupLabel(title: String) {
      
      titleLabel.text = title
      
      titleLabel.textAlignment = .center
      
      addSubview(titleLabel)
      
      backgroundColor = UIColor.blue
      
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
      let centerX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
      
      let centerY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
      
      let width = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
      
      let height = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
      
      NSLayoutConstraint.activate([centerX, centerY, width, height])
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      logFrames()
   }
   
   func logFrames() {
      print("self.frame is \(frame)")
      print("titleLabel.frame is \(titleLabel.frame)")
   }
   
   override func updateConstraints() {
      super.updateConstraints()
      logFrames()
   }
   
   
   func tapped() {
      
      
      delegate?.didTap(segment: self)
   }
   
}
