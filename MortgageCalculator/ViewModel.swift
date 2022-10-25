import Foundation
import RxCocoa
import RxSwift

final class ViewModel {
    let purchasePriceObserver: PublishRelay<Int> = .init()
    let downPaymentObserver: PublishRelay<Int> = .init()
    let repaymentTimeObserver: PublishRelay<Int> = .init()
    let interestRateObserver: PublishRelay<Int> = .init()
    
    var loanAmmount: Observable<Int> {
        return Observable.combineLatest(purchasePriceObserver,
                                        downPaymentObserver) { purchasePrice, downPayment in
            return self.countLoanAmmount(purchasePrice: purchasePrice,
                                         downPayment: downPayment)
        }
    }
    
    var paymentPerMonth: Observable<Int> {
        return Observable
            .combineLatest(purchasePriceObserver,
                                        downPaymentObserver,
                                        repaymentTimeObserver,
                                        interestRateObserver) { purchasePrice, downPayment, repaymentTime, interestRate  in
            return self.countPaymentPerMonth(purchasePrice: purchasePrice,
                                         downPayment: downPayment,
                                         repaymentTime: repaymentTime,
                                         interestRate: interestRate)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private func countLoanAmmount(purchasePrice: Int, downPayment: Int) -> Int {
        purchasePrice - downPayment
    }
    
    private func countPaymentPerMonth(purchasePrice: Int, downPayment: Int, repaymentTime: Int, interestRate: Int) -> Int {
        let loanPrice = purchasePrice - downPayment
        let percentsSum = Float(loanPrice) * (Float(interestRate) / 100) * Float(repaymentTime)
        let fullSum = loanPrice + Int(percentsSum)
        let paymentPerMonth = fullSum / repaymentTime / 12
        return paymentPerMonth
    }
}
