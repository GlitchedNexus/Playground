package pne

import (
	"errors"
	"fmt"
)

var ErrInsufficientFunds = errors.New("cannot withdraw, insufficient funds")

type Bitcoin int

type Wallet struct {
	balance Bitcoin
}

// By convention you should keep your method
// receiver types the same for consistency.

func (w *Wallet) Deposit(amount Bitcoin) {
	w.balance += amount
	// fmt.Printf("address of balance in function is %p \n", &w.balance)
}

func (w *Wallet) Balance() Bitcoin {
	return w.balance
}

func (w *Wallet) Withdraw(amount Bitcoin) error {

	if w.balance < amount {
		return ErrInsufficientFunds
	}

	w.balance -= amount

	return nil
}

// This interface is defined in the fmt package and
// lets you define how your type is printed when
// used with the %s format string in prints.
type Stringer interface {
	String() string
}

func (b Bitcoin) String() string {
	return fmt.Sprintf("%d BTC", b)
}
