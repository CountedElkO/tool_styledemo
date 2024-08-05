MAIN
DEFINE rec RECORD
    ctrl STRING,
    test1 STRING
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

    OPEN WINDOW w WITH FORM "styledemo_test" ATTRIBUTES(TEXT="Style Demo")
    INPUT BY NAME rec.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
END MAIN
