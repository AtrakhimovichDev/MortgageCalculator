import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var purchasePrice: UILabel!
    @IBOutlet weak var downPayment: UILabel!
    @IBOutlet weak var repaymentTime: UILabel!
    @IBOutlet weak var interestRate: UILabel!
    @IBOutlet weak var loanAmount: UILabel!
    @IBOutlet weak var estimatedPerMonth: UILabel!
    
    @IBOutlet weak var purchasePriceSlider: UISlider!
    @IBOutlet weak var downPaymentSlider: UISlider!
    @IBOutlet weak var repaymentTimeSlider: UISlider!
    @IBOutlet weak var interestRateSlider: UISlider!
    
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliserBindings()
        setupSubscribers()
        setupStartValue()
    }
    
    private func sliserBindings() {
        purchasePriceSlider.rx
            .value
            .map { "$\(Int(round($0 / 500) * 500).formattedWithSeparator(","))" }
            .bind(to: purchasePrice.rx.text)
            .disposed(by: disposeBag)
        
        downPaymentSlider.rx
            .value
            .map { "$\(Int(round($0 / 500) * 500).formattedWithSeparator(","))" }
            .bind(to: downPayment.rx.text)
            .disposed(by: disposeBag)
        
        repaymentTimeSlider.rx
            .value
            .map { "\(Int($0)) years" }
            .bind(to: repaymentTime.rx.text)
            .disposed(by: disposeBag)
        
        interestRateSlider.rx
            .value
            .map { "\(Int($0))%" }
            .bind(to: interestRate.rx.text)
            .disposed(by: disposeBag)
        
        purchasePriceSlider.rx
            .value
            .map { Int(round($0 / 500) * 500) }
            .bind(to: viewModel.purchasePriceObserver)
            .disposed(by: disposeBag)
        
        downPaymentSlider.rx
            .value
            .map { Int(round($0 / 500) * 500) }
            .bind(to: viewModel.downPaymentObserver)
            .disposed(by: disposeBag)
        
        repaymentTimeSlider.rx
            .value
            .map { Int($0) }
            .bind(to: viewModel.repaymentTimeObserver)
            .disposed(by: disposeBag)
        
        interestRateSlider.rx
            .value
            .map { Int($0) }
            .bind(to: viewModel.interestRateObserver)
            .disposed(by: disposeBag)
        
    }
    
    private func setupSubscribers() {
        viewModel.loanAmmount
            .map({ "$\($0.formattedWithSeparator(","))"})
            .bind(to: loanAmount.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.paymentPerMonth
            .map({ "$\($0.formattedWithSeparator(","))"})
            .bind(to: estimatedPerMonth.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupStartValue() {
        purchasePriceSlider.sendActions(for: UIControl.Event.valueChanged)
        downPaymentSlider.sendActions(for: UIControl.Event.valueChanged)
        repaymentTimeSlider.sendActions(for: UIControl.Event.valueChanged)
        interestRateSlider.sendActions(for: UIControl.Event.valueChanged)
    }
}
 

