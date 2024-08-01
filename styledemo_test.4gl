MAIN
DEFINE rec RECORD
    ctrl STRING,
    test1 STRING,
    test2 STRING
END RECORD

    WHENEVER ANY ERROR STOP
    DEFER INTERRUPT
    DEFER QUIT
    OPTIONS INPUT WRAP
    OPTIONS FIELD ORDER FORM

    CALL ui.Interface.setText("Test")
    CALL ui.Interface.loadStyles("styledemo_test.4st")
   
    CLOSE WINDOW SCREEN

    LET rec.ctrl = "Lorem Ipsum"
    LET rec.test1 = "Lorem Ipsum"
    LET rec.test2 = "loren ipsum"
    
    OPEN WINDOW w WITH FORM "styledemo_test" ATTRIBUTES(TEXT="Style Demo")
    --INPUT BY NAME rec.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)

    DISPLAY BY NAME rec.ctrl 
    INPUT BY NAME rec.test1, rec.test2 ATTRIBUTES(WITHOUT DEFAULTS = TRUE)
    
END MAIN