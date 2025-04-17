"""
COBCALC.py

A Python translation of the COBCALC.cbl COBOL program.
This program calculates the present value of a series of cash flows.
"""

def numval(string_value):
    """Converts a string to a numeric value, similar to COBOL's FUNCTION NUMVAL"""
    try:
        return float(string_value)
    except ValueError:
        return 0.0

def present_value(interest_rate, cash_flows):
    """
    Calculate the present value of a series of cash flows
    Similar to COBOL's FUNCTION PRESENT-VALUE
    
    PV = CF1/(1+r)^1 + CF2/(1+r)^2 + ... + CFn/(1+r)^n
    """
    pv = 0.0
    for i, cf in enumerate(cash_flows):
        pv += cf / ((1 + interest_rate/100) ** (i+1))
    return pv

def main():
    # Initialize variables
    call_feedback = "01"
    input_1 = "LOAN"
    buffer_array = ["LOAN", "PVALUE", "pvalue", "END", ""]
    value_amount = [0.0] * 100
    
    # Present value of a series of cash flows
    print("COBCALC - Financial Calculator")
    
    # Read loan data
    print("Enter loan amount: ")
    input_1 = input()
    value_amount[0] = numval(input_1)
    
    print("Enter interest rate (percentage): ")
    interest_in = input()
    interest = numval(interest_in)
    
    print("Enter number of periods: ")
    no_of_periods_in = input()
    no_of_periods = int(numval(no_of_periods_in))
    
    # Get cash flows for each period
    for counter in range(1, no_of_periods + 1):
        if counter < len(buffer_array):
            input_1 = buffer_array[counter - 1]
        value_amount[counter - 1] = numval(input_1)
    
    # Calculate present value
    payment = present_value(interest, value_amount[:no_of_periods])
    
    # Display result
    output_line = f"COBVALU: Present value for rate of {interest_in} given amounts {' '.join(buffer_array[:5])} is"
    print(f"{output_line} {payment:.2f}")
    
    call_feedback = "OK"
    return

if __name__ == "__main__":
    main()
