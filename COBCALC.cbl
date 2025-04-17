      **************************************************************
      * COBCALC                                                   *
      *                                                            *
      * A simple program that allows financial functions to        *
      * be performed using intrinsic functions.                    *
      *                                                            *
      **************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBCALC.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  PARM-1.
           05  CALL-FEEDBACK      PIC XX.
       01  FIELDS.
           05  INPUT-1           PIC X(10).
       01  INPUT-BUFFER-FIELDS.
           05  BUFFER-PTR        PIC 9.
           05  BUFFER-DATA.
               10  FILLER        PIC X(10)  VALUE "LOAN".
               10  FILLER        PIC X(10)  VALUE "PVALUE".
               10  FILLER        PIC X(10)  VALUE "pvalue".
               10  FILLER        PIC X(10)  VALUE "END".
           05  BUFFER-ARRAY      REDEFINES BUFFER-DATA
                                 OCCURS 4 TIMES
                                 PIC X(10).
       01  PAYMENT-OUT           PIC X(80).
       01  INTEREST-IN           PIC S9(9) COMP.
       01  INTEREST              PIC S9(9) COMP.
       01  NO-OF-PERIODS-IN      PIC S9(9) COMP.
       01  NO-OF-PERIODS         PIC S9(9) COMP.
       01  PAYMENT               PIC S9(9)V99 COMP.
       01  VALUE-AMOUNT          PIC S9(9)V99 COMP
                                 OCCURS 100 TIMES.

       PROCEDURE DIVISION.
       MAIN-ROUTINE.
      * Present value of a series of cash flows
           MOVE "01" TO CALL-FEEDBACK.
           MOVE "LOAN" TO INPUT-1.
      * Read loan data
           PERFORM READ-LOAN-DATA.
      * Calculate present value
           COMPUTE INTEREST = FUNCTION NUMVAL(INTEREST-IN).          VALU2
           COMPUTE NO-OF-PERIODS = FUNCTION NUMVAL(NO-OF-PERIODS-IN).
      * Get cash flows
           PERFORM GET-AMOUNTS VARYING COUNTER FROM 1 BY 1 UNTIL
                 COUNTER IS GREATER THAN NO-OF-PERIODS.
      * Calculate present value
           COMPUTE PAYMENT =
                 FUNCTION PRESENT-VALUE(INTEREST VALUE-AMOUNT(ALL) ).    VALU3
      * Make it presentable
           MOVE PAYMENT TO PAYMENT-OUT.
           STRING "COBVALU: Present_value_for_rate_of_"
                 INTEREST-IN " given amounts "
                 BUFFER-ARRAY (1) "_" 
                 BUFFER-ARRAY (2) "_"
                 BUFFER-ARRAY (3) "_"
                 BUFFER-ARRAY (4) "_"
                 BUFFER-ARRAY (5) "_is_"
           DELIMITED BY SPACES
           INTO OUTPUT-LINE.
           INSPECT OUTPUT-LINE REPLACING ALL "_" BY SPACES.
           DISPLAY OUTPUT-LINE PAYMENT-OUT.
           MOVE "OK" TO CALL-FEEDBACK.
           GOBACK.
       
      * Get cash flows for each period
       GET-AMOUNTS.
           MOVE BUFFER-ARRAY (COUNTER) TO INPUT-1.
           COMPUTE VALUE-AMOUNT (COUNTER) = FUNCTION NUMVAL(INPUT-1).
           
       READ-LOAN-DATA.
      * Read loan amount and interest rate
           DISPLAY "Enter loan amount: ".
           ACCEPT INPUT-1.
           COMPUTE VALUE-AMOUNT(1) = FUNCTION NUMVAL(INPUT-1).
           DISPLAY "Enter interest rate (percentage): ".
           ACCEPT INTEREST-IN.
           DISPLAY "Enter number of periods: ".
           ACCEPT NO-OF-PERIODS-IN.
           
       END PROGRAM COBCALC.