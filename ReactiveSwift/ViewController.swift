import UIKit

class PushedViewController: UIViewController {
  
  var currentWeather: Observable<Double>!
  private let disposeBag = MyDisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Add an observer everytime view controller is presented
    currentWeather.observe { newTemperature in
      print("lastest temperature #\(newTemperature)")
      }.disposed(by: disposeBag)
  }
  deinit {
    print("deallocating pushed view controller")
  }
}

class ViewController: UIViewController {
  
  private let disposeBag = MyDisposeBag()
  var currentWeather: Observable<Double> = Observable(80)
  
  @IBOutlet weak var observerCountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    currentWeather.observe { [weak self] newTemperature in
      guard let strongSelf = self else { return }
      
      strongSelf.observerCountLabel.text = String(describing: strongSelf.currentWeather.observers.count)
      }.disposed(by: disposeBag)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    currentWeather.value = 100
  }
  
  @IBAction func pushing(_ sender: Any) {
    let dvc = storyboard?.instantiateViewController(withIdentifier: "PushedViewController") as! PushedViewController
    dvc.currentWeather = currentWeather
    navigationController?.pushViewController(dvc, animated: true)
  }
}
