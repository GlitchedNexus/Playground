package itpbt

import (
	"strings"
)

type RomanNumerals struct {
	Value  int
	Symbol string
}

var allRomanNumerals = []RomanNumerals{
	{1000, "M"},
	{900, "CM"},
	{500, "D"},
	{400, "CD"},
	{100, "C"},
	{90, "XC"},
	{50, "L"},
	{40, "XL"},
	{10, "X"},
	{9, "IX"},
	{5, "V"},
	{4, "IV"},
	{1, "I"},
}

func ConvertToRoman(arabic int) string {

	var result strings.Builder

	for _, numeral := range allRomanNumerals {
		for arabic >= numeral.Value {
			result.WriteString(numeral.Symbol)
			arabic -= numeral.Value
		}
	}

	return result.String()
}

func ConvertToArabic(roman string) int {
	index := 0
	result := 0

	for _, i := range allRomanNumerals {
		if len(roman) <= index {
			return result
		}
		curr := roman[index:]
		value := i.Value
		symbol := i.Symbol

		if curr == "" {
			return result
		}

		count := 0
		for strings.HasPrefix(curr, symbol) {
			index += len(symbol)
			count++
			if len(roman) <= index {
				break
			}
			curr = roman[index:]
		}

		result += value * count

	}

	return result
}
