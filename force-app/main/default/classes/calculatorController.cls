public class calculatorController {
    @Auraenabled
    public static decimal calculateValues(decimal firstNumber, decimal secondNumber){
        decimal sum = firstNumber + secondNumber;
        return sum;
    }
}