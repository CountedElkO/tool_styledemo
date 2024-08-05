IMPORT xml
IMPORT util
IMPORT FGL styledemo_launcher_db
--IMPORT FGL fgldialog

TYPE itemsListType DYNAMIC ARRAY OF STRING

DEFINE m_data RECORD

    case_style_name STRING,
    widget_name STRING,
    widget_2_name STRING,
    container_name STRING,
    dialog_name STRING,
    dataType_name STRING,
    datatype_2_name STRING,

    widget_attribute_arr DYNAMIC ARRAY OF RECORD
        widget_attribute_name STRING,
        widget_attribute_value STRING
    END RECORD,
    widget_2_attribute_arr DYNAMIC ARRAY OF RECORD
        widget_2_attribute_name STRING,
        widget_2_attribute_value STRING
    END RECORD,
    widget_style_arr DYNAMIC ARRAY OF RECORD
        widget_style_attribute_name STRING,
        widget_style_attribute_value STRING
    END RECORD,
    widget_2_style_arr DYNAMIC ARRAY OF RECORD
        widget_2_style_attribute_name STRING,
        widget_2_style_attribute_value STRING
    END RECORD
END RECORD
DEFINE case_style, fileName, s, widget_2_flag STRING
DEFINE t TEXT
MAIN
    WHENEVER ANY ERROR STOP
    DEFER INTERRUPT
    DEFER QUIT
    OPTIONS INPUT WRAP
    OPTIONS FIELD ORDER FORM
    CONNECT TO ":memory:+driver='dbmsqt'"
    CALL populate_db()
    CALL ui.Interface.loadStyles("styledemo_launcher.4st")
    CALL ui.Interface.loadActionDefaults("styledemo_launcher.4ad")
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "styledemo_launcher" ATTRIBUTES(STYLE="maximized")
    
    CALL ui.Interface.setText("Launcher")
    -- Default values
    LET m_data.case_style_name = "UPPERCASE"
    LET m_data.container_name = "grid"
    LET m_data.widget_name = "edit"
    LET m_data.dialog_name = "input"
    LET m_data.dataType_name = "char"
    LET m_data.widget_2_name = "edit"
    LET m_data.datatype_2_name = "char"
    LET widget_2_flag = 0
    -- Hides second widget fields
    CALL ui.Window.getCurrent().getForm().setElementHidden("remove_widget", 2)
    CALL ui.Window.getCurrent().getForm().setElementHidden("formonly.widget_2_name", 2)
    CALL ui.Window.getCurrent().getForm().setElementHidden("formonly.datatype_2_name", 2)
    CALL ui.Window.getCurrent().getForm().setElementHidden("p2", 2)
    CALL ui.Window.getCurrent().getForm().setElementHidden("p4", 2)
    -- Initial display of generated code
    DISPLAY build_4gl() TO fourgl
    DISPLAY build_per() TO per
    DISPLAY build_4st() TO st
    DIALOG ATTRIBUTES(UNBUFFERED)
        -- INPUT ARRAY for comboboxes
        INPUT BY NAME m_data.case_style_name, m_data.container_name, m_data.widget_name, m_data.dialog_name, m_data.dataType_name, m_data.widget_2_name, m_data.datatype_2_name ATTRIBUTES (WITHOUT DEFAULTS = TRUE) 
            ON CHANGE case_style_name
                LET case_style = m_data.case_style_name
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("container_name"))
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("widget_name"))
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("dialog_name"))
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("dataType_name"))
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("widget_2_name"))
                CALL comboBoxFiller(case_style, ui.ComboBox.forName("datatype_2_name"))
        END INPUT
        -- INPUT ARRAY for Widget Attributes tab
        INPUT ARRAY m_data.widget_attribute_arr FROM widget_attribute_scr.* ATTRIBUTES(INSERT ROW = FALSE)
            BEFORE INPUT
                CALL ui.Window.getCurrent().getForm().ensureElementVisible("pgper")

            ON CHANGE widget_attribute_name
                CALL populate_widget_attribute_name(DIALOG, m_data.widget_name, m_data.widget_attribute_arr[arr_curr()].widget_attribute_name)

            ON CHANGE widget_attribute_value
                CALL populate_widget_attribute_value(DIALOG, m_data.widget_attribute_arr[arr_curr()].widget_attribute_name, m_data.widget_attribute_arr[arr_curr()].widget_attribute_value) 

            AFTER FIELD widget_attribute_name
                DISPLAY build_per() TO per

            AFTER FIELD widget_attribute_value
                DISPLAY build_per() TO per
            
            AFTER ROW
                DISPLAY build_per() TO per
        END INPUT
        -- INPUT ARRAY for Widget 2 Attributes tab
        INPUT ARRAY m_data.widget_2_attribute_arr FROM widget_2_attribute_scr.* ATTRIBUTES(INSERT ROW = FALSE)
            BEFORE INPUT
                CALL ui.Window.getCurrent().getForm().ensureElementVisible("pgper")

            ON CHANGE widget_2_attribute_name
                CALL populate_widget_attribute_name(DIALOG, m_data.widget_2_name, m_data.widget_2_attribute_arr[arr_curr()].widget_2_attribute_name)

            ON CHANGE widget_2_attribute_value
                CALL populate_widget_attribute_value(DIALOG, m_data.widget_2_attribute_arr[arr_curr()].widget_2_attribute_name, m_data.widget_2_attribute_arr[arr_curr()].widget_2_attribute_value) 

            AFTER FIELD widget_2_attribute_name
                DISPLAY build_per() TO per

            AFTER FIELD widget_2_attribute_value
                DISPLAY build_per() TO per
            
            AFTER ROW
                DISPLAY build_per() TO per
        END INPUT
        -- INPUT ARRAY for Widget Styles tab
        INPUT ARRAY m_data.widget_style_arr FROM widget_style_scr.* ATTRIBUTES(INSERT ROW = FALSE)
            BEFORE INPUT
                CALL ui.Window.getCurrent().getForm().ensureElementVisible("pg4st")

            ON CHANGE widget_style_attribute_name
                CALL populate_widget_style_name(DIALOG, m_data.widget_name, m_data.widget_style_arr[arr_curr()].widget_style_attribute_name)
            ON CHANGE widget_style_attribute_value
                CALL populate_widget_style_value(
                    DIALOG, m_data.widget_style_arr[arr_curr()].widget_style_attribute_name,
                    m_data.widget_style_arr[arr_curr()].widget_style_attribute_value)

            AFTER FIELD widget_style_attribute_value
                DISPLAY build_4st() TO st

            AFTER ROW
                DISPLAY build_4st() TO st

        END INPUT
        --Unhides and hides the second widget
        ON ACTION add_widget
            LET widget_2_flag = 1
            CALL DIALOG.getForm().setElementHidden("add_widget", 2)
            CALL DIALOG.getForm().setElementHidden("remove_widget", 0)
            CALL DIALOG.getForm().setElementHidden("formonly.widget_2_name", 0)
            CALL DIALOG.getForm().setElementHidden("formonly.datatype_2_name", 0)
            CALL DIALOG.getForm().setElementHidden("p2", 0)
            CALL DIALOG.getForm().setElementHidden("p4", 0)
            DISPLAY build_4gl() TO fourgl
        ON ACTION remove_widget
            LET widget_2_flag = 0
            CALL DIALOG.getForm().setElementHidden("add_widget", 0)
            CALL DIALOG.getForm().setElementHidden("formonly.widget_2_name", 2)
            CALL DIALOG.getForm().setElementHidden("formonly.datatype_2_name", 2)
            CALL DIALOG.getForm().setElementHidden("remove_widget", 2)
            CALL DIALOG.getForm().setElementHidden("p2", 2)
            CALL DIALOG.getForm().setElementHidden("p4", 2)
            DISPLAY build_4gl() TO fourgl
        --Displays the generated code
        ON ACTION display_files
            DISPLAY build_4gl() TO fourgl
            DISPLAY build_per() TO per
            DISPLAY build_4st() TO st
        --Displays final generated code and runs the test application
        ON ACTION go
            DISPLAY build_4gl() TO fourgl
            DISPLAY build_per() TO per
            DISPLAY build_4st() TO st
            WHENEVER ERROR CONTINUE
            RUN "fglform styledemo_test.per"
            -- TODO handle case if form fails to compile
            RUN "fglrun styledemo_test" WITHOUT WAITING
            
        --Clears all fields
        ON ACTION CLEAR ATTRIBUTES(TEXT="Clear")
            INITIALIZE m_data TO NULL
        --Imports JSON file
        ON ACTION IMPORT ATTRIBUTES(TEXT="Import")
            --CALL ui.Interface.frontCall("standard", "openFile")
            {CALL fgl_winMessage("Info", "Not Implemented", "info") -- TODO read json file and serialize into m_data}
        --Exports JSON file
        ON ACTION export ATTRIBUTES(TEXT="Export")
            LET s = util.JSON.stringify(m_data)
            LOCATE t in MEMORY
            LET t = s
            CALL t.writeFile("styledemo_launcher.json")
            CALL ui.Interface.frontCall("standard", "saveFile", ["","","","saveFile"],[fileName])
            CALL fgl_putfile("styledemo_launcher.json", fileName)

        --Exits the application 
        ON ACTION close
            EXIT DIALOG
    END DIALOG
END MAIN

-- Fills comboboxes with names based on case_style
FUNCTION comboBoxFiller(case_style STRING, comboBox ui.ComboBox)
    DEFINE sql_statement, list, data_variable, table_name, column_name, cmb_name STRING
    CALL comboBox.clear()
    LET cmb_name = comboBox.getColumnName()
    CASE cmb_name
        WHEN "container_name"
            LET table_name = "container_names"
            LET column_name = "container"
        WHEN "widget_name"
            LET table_name = "widget_names"
            LET column_name = "widget"
        WHEN "dialog_name"
            LET table_name = "dialog_names"
            LET column_name = "dialog"
        WHEN "datatype_name"
            LET table_name = "datatype_names"
            LET column_name = "datatype"
        WHEN "widget_2_name"
            LET table_name = "widget_names"
            LET column_name = "widget"
        WHEN "datatype_2_name"
            LET table_name = "datatype_names"
            LET column_name = "datatype"
    END CASE
    IF case_style == "camelCase" THEN
        LET column_name = "camelcase"
        LET sql_statement = "SELECT " || column_name || " FROM " || table_name || " ORDER BY weight"
    ELSE 
        LET sql_statement = "SELECT " || column_name || " FROM " || table_name || " ORDER BY weight"
    END IF
    LET list = NULL
    DECLARE comboBox_curs CURSOR FROM sql_statement
    OPEN comboBox_curs
    FOREACH comboBox_curs INTO list
        -- TODO seperate logic and display
        LET data_variable = list
        IF case_style == "UPPERCASE" THEN
            LET list = upshift(list)
        END IF
        CALL comboBox.addItem(data_variable, list)
    END FOREACH
    CLOSE comboBox_curs
END FUNCTION
--ComboBox Initializer
FUNCTION firstComboBox(comboBox ui.ComboBox)
    LET case_style = "UPPERCASE"
    CALL comboBoxFiller(case_style, comboBox)
END FUNCTION

-- Fills dialog box when typing in Name column of Widget Attributes tab
FUNCTION populate_widget_attribute_name(d ui.Dialog, widget STRING, BUFFER STRING)
    DEFINE list itemsListType

    CALL populate_widget_attribute_name_sql(widget, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_widget_attribute_name_sql(widget STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE sql STRING
    DEFINE name STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 name FROM widget_attribute_names WHERE widget = ? AND name LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"

    DECLARE widget_attribute_name_curs CURSOR FROM sql
    OPEN widget_attribute_name_curs USING widget, BUFFER

    FOREACH widget_attribute_name_curs INTO name
        LET list[list.getLength() + 1] = name
    END FOREACH
    RETURN list
END FUNCTION
-- Fills dialog box when typing in Value column of Widget Attributes tab
FUNCTION populate_widget_attribute_value(d ui.Dialog, NAME STRING,  BUFFER STRING)
    DEFINE list itemsListType

    CALL populate_widget_attribute_value_sql(NAME, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_widget_attribute_value_sql(NAME STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE sql STRING
    DEFINE value STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 value FROM widget_attribute_values WHERE name = ? AND value LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"

    DECLARE widget_attribute_value_curs CURSOR FROM sql
    OPEN widget_attribute_value_curs USING NAME, BUFFER

    FOREACH widget_attribute_value_curs INTO value
        LET list[list.getLength() + 1] = value
    END FOREACH
    RETURN list
END FUNCTION

-- Fills dialog box when typing in Name column of Widget Styles tab
FUNCTION populate_widget_style_name(d ui.Dialog, widget STRING, BUFFER STRING)
    DEFINE list itemsListType

    CALL populate_widget_style_name_sql(widget, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_widget_style_name_sql(widget STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE widget_sql, common_sql STRING
    DEFINE name STRING
    DEFINE list itemsListType

    LET widget_sql = "SELECT FIRST 50 name FROM widget_style_names WHERE widget = ? AND name LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"
    LET common_sql = "SELECT FIRST 50 name FROM style_names WHERE widget = ? AND name LIKE ? ORDER BY weight, name"
    DECLARE widget_style_name_curs CURSOR FROM widget_sql
    OPEN widget_style_name_curs USING widget, BUFFER
    FOREACH widget_style_name_curs INTO name
        LET list[list.getLength() + 1] = name
    END FOREACH
    DECLARE common_style_name_curs CURSOR FROM common_sql
    OPEN common_style_name_curs USING "common", BUFFER
    FOREACH common_style_name_curs INTO name
        LET list[list.getLength() + 1] = name
    END FOREACH
    RETURN list
END FUNCTION
-- Fills dialog box when typing in Value column of Widget Styles tab
FUNCTION populate_widget_style_value(d ui.Dialog, name CHAR(20), BUFFER STRING)
    DEFINE list itemsListType
    CASE name
        WHEN "backgroundColor"
            LET name = "color"
        WHEN "defaultTTFColor"
            LET name = "color"
        WHEN "textColor"
            LET name = "color"
        OTHERWISE
            LET name = name
    END CASE
    CALL populate_widget_style_value_sql(name, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_widget_style_value_sql(name STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE widget_sql, common_sql STRING
    DEFINE value STRING
    DEFINE list itemsListType

    LET widget_sql = "SELECT FIRST 50 value FROM widget_style_values WHERE name = ? AND value LIKE ? ORDER BY weight, name"
    LET common_sql = "SELECT FIRST 50 value FROM common_style_attributes WHERE name = ? AND value LIKE ? ORDER BY weight, value"
    LET BUFFER = BUFFER, "%"

    DECLARE widget_style_value_curs CURSOR FROM widget_sql
    OPEN widget_style_value_curs USING name, BUFFER
    FOREACH widget_style_value_curs INTO value
        LET list[list.getLength() + 1] = value
    END FOREACH
    DECLARE common_style_value_curs CURSOR FROM common_sql
    OPEN common_style_value_curs USING name, BUFFER
    FOREACH common_style_value_curs INTO value
        LET list[list.getLength() + 1] = value
    END FOREACH
    RETURN list
END FUNCTION

-- build per file
--write from scratch
FUNCTION build_per() RETURNS STRING
    DEFINE sb base.StringBuffer
    DEFINE i INTEGER
    DEFINE container_name, widget_name, widget_2_name STRING

    LET sb = base.StringBuffer.create()
    IF case_style == "UPPERCASE" THEN
        LET container_name = upshift(m_data.container_name)
        LET widget_name = upshift(m_data.widget_name)
        LET widget_2_name = upshift(m_data.widget_2_name)
    ELSE
        LET container_name = m_data.container_name
        LET widget_name = m_data.widget_name
        LET widget_2_name = m_data.widget_2_name
    END IF
    CALL sb.append("LAYOUT (TEXT=\"Widget & Style Demo\")\n")
    IF m_data.container_name == "grid" THEN
        CALL sb.append("    " || container_name || "\n" || "    {\n")  -- TODO set grid width to entered value
        CALL sb.append("        Control [f01                 : ]\n" || "        Test    [f02                 : ]\n")
        IF widget_2_flag == 1 THEN
            Call sb.append("        Test2   [f03                 : ]\n")
        END IF
        CALL sb.append("    }\n")
    ELSE IF m_data.container_name == "table" THEN
        CALL sb.append("    " || container_name || "\n" || "    {\n") -- TODO set table width to entered value
        IF widget_2_flag == 1 THEN
            CALL sb.append("        Control     Test     Test2     \n" || "        [f01        |f02        |f03        ]\n")
        ELSE
            CALL sb.append("     Control     Test     \n" || "    [f01        |f02        ]\n")
        END IF
        CALL sb.append("    }\n")
    END IF
    END IF
    CALL sb.append("    END\n")
    CALL sb.append("END\n" || "ATTRIBUTES\n")
    CALL sb.append(widget_name || " f01 = formonly.ctrl;\n")
    CALL sb.append(widget_name || " f02 = formonly.test1, STYLE=\"test1\"")
    FOR i = 1 TO m_data.widget_attribute_arr.getLength()
        IF m_data.widget_attribute_arr[i].widget_attribute_name.getLength() > 0 THEN
            CALL sb.append(", ")
            IF case_style == "UPPERCASE" THEN
                CALL sb.append(upshift(m_data.widget_attribute_arr[i].widget_attribute_name))
            ELSE
                CALL sb.append(downshift(m_data.widget_attribute_arr[i].widget_attribute_name))
            END IF
        END IF
        IF m_data.widget_attribute_arr[i].widget_attribute_value.getLength() > 0 THEN
            CALL sb.append(" = ")
            IF m_data.widget_attribute_arr[i].widget_attribute_name == "comment" || m_data.widget_attribute_arr[i].widget_attribute_name == "placeholder" THEN
                CALL sb.append("\"" || m_data.widget_attribute_arr[i].widget_attribute_value || "\"")
            ELSE
                CALL sb.append(m_data.widget_attribute_arr[i].widget_attribute_value)
            END IF
        END IF
    END FOR
    IF widget_2_flag == 1 THEN
        CALL sb.append(";\n")
        CALL sb.append(widget_2_name || " f03 = formonly.test2, STYLE=\"test2\"")
        FOR i = 1 to m_data.widget_2_attribute_arr.getLength()
            IF m_data.widget_2_attribute_arr[i].widget_2_attribute_name.getLength() > 0 THEN
                CALL sb.append(", ")
                IF case_style == "UPPERCASE" THEN
                    CALL sb.append(upshift(m_data.widget_2_attribute_arr[i].widget_2_attribute_name))
                ELSE
                    CALL sb.append(downshift(m_data.widget_2_attribute_arr[i].widget_2_attribute_name))
                END IF
            END IF
            IF m_data.widget_2_attribute_arr[i].widget_2_attribute_value.getLength() > 0 THEN
                CALL sb.append(" = ")
                IF m_data.widget_2_attribute_arr[i].widget_2_attribute_name == "comment" || m_data.widget_2_attribute_arr[i].widget_2_attribute_name == "placeholder" THEN
                    CALL sb.append("\"" || m_data.widget_2_attribute_arr[i].widget_2_attribute_value || "\"")
                ELSE
                    CALL sb.append(m_data.widget_2_attribute_arr[i].widget_2_attribute_value)
                END IF
            END IF
        END FOR
    END IF
    CALL sb.append(";\n")
    CALL sb.append("END\n")

    VAR t TEXT
    LOCATE t IN MEMORY
    LET t = sb.toString()
    CALL t.writeFile("styledemo_test.per")
    RETURN sb.toString()
END FUNCTION

-- build 4gl file
-- TODO implement dialogs of INPUT and Construct
FUNCTION build_4gl() RETURNS STRING
    DEFINE sb base.StringBuffer
    --DEFINE i INTEGER

    LET sb = base.StringBuffer.create()
    CALL sb.append("MAIN\n")
    CALL sb.append("DEFINE rec RECORD\n")
    CALL sb.append("    ctrl STRING,\n")
    CALL sb.append("    test1 STRING")
    IF widget_2_flag == 1 THEN
        CALL sb.append(",\n" || "    test2 STRING\n")
    ELSE
        CALL sb.append("\n")
    END IF
    CALL sb.append("END RECORD\n" || "\n")
    CALL sb.append("    WHENEVER ANY ERROR STOP\n")
    CALL sb.append("    DEFER INTERRUPT\n")
    CALL sb.append("    DEFER QUIT\n")
    CALL sb.append("    OPTIONS INPUT WRAP\n")
    CALL sb.append("    OPTIONS FIELD ORDER FORM\n" || "\n")
    CALL sb.append("    CALL ui.Interface.setText(\"Test\")\n")
    CALL sb.append("    CALL ui.Interface.loadStyles(\"styledemo_test.4st\")\n" || "\n")
    CALL sb.append("    CLOSE WINDOW SCREEN\n" || "\n")
    CALL sb.append("    LET rec.ctrl = \"Lorem Ipsum\"\n")
    CALL sb.append("    LET rec.test1 = \"Lorem Ipsum\"\n" )
    IF widget_2_flag == 1 THEN
        CALL sb.append("    LET rec.test2 = \"Lorem Ipsum\"\n" || "\n")
    ELSE
        CALL sb.append("\n")
    END IF
    CALL sb.append("    OPEN WINDOW w WITH FORM \"styledemo_test\" ATTRIBUTES(TEXT=\"Style Demo\")\n")
    CALL sb.append("    INPUT BY NAME rec.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)\n")
    CALL sb.append("END MAIN\n")

    VAR t TEXT
    LOCATE t IN MEMORY
    LET t = sb.toString()
    CALL t.writeFile("styledemo_test.4gl")
    RETURN sb.toString()
END FUNCTION

-- build 4st file.
-- TODO 
-- Start from a template file and append nodes
FUNCTION build_4st() RETURNS STRING
    DEFINE doc xml.DomDocument
    DEFINE stylelist_node, style_node, styleattribute_node xml.DomNode
    DEFINE i INTEGER

    LET doc = xml.DomDocument.Create()
    CALL doc.load("styledemo_launcher_template.4st")
    CALL doc.setFeature("format-pretty-print", TRUE)
    LET stylelist_node = doc.getDocumentElement()

    LET style_node = stylelist_node.appendChildElement("Style")
    CALL style_node.setAttribute("name", ".test1")
    FOR i = 1 TO m_data.widget_style_arr.getLength()
        LET styleattribute_node = style_node.appendChildElement("StyleAttribute")
        CALL styleattribute_node.setAttribute("name", m_data.widget_style_arr[i].widget_style_attribute_name)
        CALL styleattribute_node.setAttribute("value", m_data.widget_style_arr[i].widget_style_attribute_value)
    END FOR
    IF widget_2_flag == 1 THEN
        LET style_node = stylelist_node.appendChildElement("Style")
        CALL style_node.setAttribute("name", ".test2")
        FOR i = 1 TO m_data.widget_2_style_arr.getLength()
            LET styleattribute_node = style_node.appendChildElement("StyleAttribute")
            CALL styleattribute_node.setAttribute("name", m_data.widget_2_style_arr[i].widget_2_style_attribute_name)
            CALL styleattribute_node.setAttribute("value", m_data.widget_2_style_arr[i].widget_2_style_attribute_value)
        END FOR
    END IF
    -- .test Style
    {LET style_node = stylelist_node.appendChildElement("Style")
    CALL style_node.setAttribute("name", ".test")
    FOR i = 1 TO m_data.common_style_arr.getLength()
        LET styleattribute_node = style_node.appendChildElement("StyleAttribute")
        CALL styleattribute_node.setAttribute("name", m_data.common_style_arr[i].common_style_attribute_name)
        CALL styleattribute_node.setAttribute("value", m_data.common_style_arr[i].common_style_attribute_value)
    END FOR}
    CALL doc.save("styledemo_test.4st")
    RETURN stylelist_node.toString()
END FUNCTION
