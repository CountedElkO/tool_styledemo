IMPORT xml
IMPORT FGL styledemo_launcher_db
IMPORT FGL fgldialog

TYPE itemsListType DYNAMIC ARRAY OF STRING

DEFINE m_data RECORD

    case_style_name STRING,
    widget_name STRING,
    container_name STRING,
    dialog_name STRING,
    dataType_name STRING,

    widget_attribute_arr DYNAMIC ARRAY OF RECORD
        widget_attribute_name STRING,
        widget_attribute_value STRING
    END RECORD,
    widget_style_arr DYNAMIC ARRAY OF RECORD
        widget_style_attribute_name STRING,
        widget_style_attribute_value STRING
    END RECORD,
    common_style_arr DYNAMIC ARRAY OF RECORD
        common_style_attribute_name STRING,
        common_style_attribute_value STRING
    END RECORD
END RECORD
DEFINE case_style STRING
DEFINE fileName STRING
MAIN
    WHENEVER ANY ERROR STOP
    DEFER INTERRUPT
    DEFER QUIT
    OPTIONS INPUT WRAP
    OPTIONS FIELD ORDER FORM

    CALL ui.Interface.loadStyles("styledemo_launcher.4st")
    CALL ui.Interface.loadActionDefaults("styledemo_launcher.4ad")
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "styledemo_launcher" ATTRIBUTES(STYLE="maximized")
    
    CALL ui.Interface.setText("Launcher")
    
    CONNECT TO ":memory:+driver='dbmsqt'"
    CALL populate_db()
    
    DIALOG ATTRIBUTES(UNBUFFERED)
        -- INPUT for comboboxes
        INPUT BY NAME m_data.case_style_name, m_data.widget_name, m_data.container_name, m_data.dialog_name, m_data.dataType_name ATTRIBUTES(WITHOUT DEFAULTS = TRUE)
            ON CHANGE case_style_name
                CALL case_style_selector()
                CALL comboBoxFiller(case_style)
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
        -- INPUT ARRAY for Common Styles tab
        INPUT ARRAY m_data.common_style_arr FROM common_style_scr.* ATTRIBUTES(INSERT ROW = FALSE)
            BEFORE INPUT
                CALL ui.Window.getCurrent().getForm().ensureElementVisible("pg4st")

            ON CHANGE common_style_attribute_name
                CALL populate_style_name(DIALOG, "common", m_data.common_style_arr[arr_curr()].common_style_attribute_name)

            ON CHANGE common_style_attribute_value
                CALL populate_style_value(
                    DIALOG, m_data.common_style_arr[arr_curr()].common_style_attribute_name,
                    m_data.common_style_arr[arr_curr()].common_style_attribute_value)

            AFTER FIELD common_style_attribute_value
                DISPLAY build_4st() TO st

            AFTER ROW
                DISPLAY build_4st() TO st

        END INPUT
        
        ON ACTION go
            DISPLAY build_per() TO per
            DISPLAY build_4st() TO st
            WHENEVER ERROR CONTINUE
            RUN "fglform styledemo_test.per"
            -- TODO handle case if form fails to compile
            RUN "fglrun styledemo_test" WITHOUT WAITING
            
        ON ACTION CLEAR ATTRIBUTES(TEXT="Clear")
            INITIALIZE m_data TO NULL
            
        ON ACTION IMPORT ATTRIBUTES(TEXT="Import")
            --CALL ui.Interface.frontCall("standard", "openFile")
            {CALL fgl_winMessage("Info", "Not Implemented", "info") -- TODO read json file and serialize into m_data}
            
        ON ACTION export ATTRIBUTES(TEXT="Export")
            CALL ui.Interface.frontCall("standard", "saveFile", ["","","","saveFile"],[fileName])
            -- TODO CALL fgl_putFile(, fileName)
            -- JSON toString
            --CALL fgl_winMessage("Info", fileName, "info") -- TODO implement serialize m_data to json and write to file
            
        ON ACTION close
            EXIT DIALOG
    END DIALOG
END MAIN

FUNCTION case_style_selector ()
    CASE m_data.case_style_name
        WHEN "UPPERCASE"
            LET case_style = "upshift"
        WHEN "camelCase"
            LET case_style = "camelCase"
        WHEN "lowercase"
            LET case_style = "downshift"
    END CASE
END FUNCTION
-- Fills comboboxes with names based on case_style
FUNCTION comboBoxFiller(case_style STRING)
    DEFINE widget_sql, container_sql, dialog_sql, datatype_sql STRING
    DEFINE list STRING
    DEFINE i INTEGER
    LET i = 1
    CALL ui.ComboBox.forName("container_name").clear()
    CALL ui.ComboBox.forName("widget_name").clear()
    CALL ui.ComboBox.forName("dialog_name").clear()
    CALL ui.ComboBox.forName("dataType_name").clear()
    IF case_style == "camelCase" THEN
        LET widget_sql = "SELECT widget_camelcase FROM widget_names ORDER BY weight"
        LET container_sql = "SELECT container_camelcase FROM container_names ORDER BY weight"
        LET dialog_sql = "SELECT dialog_camelcase FROM dialog_names ORDER BY weight"
        LET datatype_sql = "SELECT datatype_camelcase FROM datatype_names ORDER BY weight"
    ELSE 
        LET widget_sql = "SELECT widget FROM widget_names ORDER BY weight"
        LET container_sql = "SELECT container FROM container_names ORDER BY weight"
        LET dialog_sql = "SELECT dialog FROM dialog_names ORDER BY weight"
        LET datatype_sql = "SELECT datatype FROM datatype_names ORDER BY weight"
    END IF
    DECLARE widget_curs CURSOR FROM widget_sql
    OPEN widget_curs
    FOREACH widget_curs INTO list
        IF case_style == "upshift" THEN
            LET list = upshift(list)
        END IF
        CALL ui.ComboBox.forName("widget_name").addItem(i, list)
        LET i += 1
    END FOREACH
    CLOSE widget_curs
    LET i = 1
    LET list = NULL
    DECLARE container_curs CURSOR FROM container_sql
    OPEN container_curs
    FOREACH container_curs INTO list
        IF case_style == "upshift" THEN
            LET list = upshift(list)
        END IF
        CALL ui.ComboBox.forName("container_name").addItem(i, list)
        LET i += 1
    END FOREACH
    CLOSE container_curs
    LET i = 1
    LET list = NULL
    DECLARE dialog_curs CURSOR FROM dialog_sql
    OPEN dialog_curs
    FOREACH dialog_curs INTO list
        IF case_style == "upshift" THEN
            LET list = upshift(list)
        END IF
        CALL ui.ComboBox.forName("dialog_name").addItem(i, list)
        LET i += 1
    END FOREACH
    CLOSE dialog_curs
    LET i = 1
    LET list = NULL
    DECLARE datatype_curs CURSOR FROM datatype_sql
    OPEN datatype_curs
    FOREACH datatype_curs INTO list
        IF case_style == "upshift" THEN
            LET list = upshift(list)
        END IF
        CALL ui.ComboBox.forName("datatype_name").addItem(i, list)
        LET i += 1
    END FOREACH
    CLOSE datatype_curs
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
    DEFINE sql STRING
    DEFINE name STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 name FROM widget_style_names WHERE widget = ? AND name LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"

    DECLARE widget_style_name_curs CURSOR FROM sql
    OPEN widget_style_name_curs USING widget, BUFFER

    FOREACH widget_style_name_curs INTO name
        LET list[list.getLength() + 1] = name
    END FOREACH
    RETURN list
END FUNCTION

-- Fills dialog box when typing in Value column of Widget Styles tab
FUNCTION populate_widget_style_value(d ui.Dialog, name CHAR(20), BUFFER STRING)
    DEFINE list itemsListType

    CALL populate_widget_style_value_sql(name, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_widget_style_value_sql(name STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE sql STRING
    DEFINE value STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 value FROM widget_style_values WHERE name = ? AND value LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"

    DECLARE widget_style_value_curs CURSOR FROM sql
    OPEN widget_style_value_curs USING name, BUFFER

    FOREACH widget_style_value_curs INTO value
        LET list[list.getLength() + 1] = value
    END FOREACH
    RETURN list
END FUNCTION

-- Fills dialog box when typing in Name column of Common Styles tab
FUNCTION populate_style_name(d ui.Dialog, widget STRING, BUFFER STRING)
    DEFINE list itemsListType

    CALL populate_completer_name_sql(widget, BUFFER) RETURNING list
    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_completer_name_sql(widget STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE sql STRING
    DEFINE name STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 name FROM style_names WHERE widget = ? AND name LIKE ? ORDER BY weight, name"
    LET BUFFER = BUFFER, "%"

    DECLARE style_name_curs CURSOR FROM sql
    OPEN style_name_curs USING widget, BUFFER

    FOREACH style_name_curs INTO name
        LET list[list.getLength() + 1] = name
    END FOREACH
    RETURN list
END FUNCTION

-- Fills dialog box when typing in Value column of Common Styles tab
FUNCTION populate_style_value(d ui.Dialog, att STRING, BUFFER STRING)
    DEFINE list itemsListType

    CASE att
        WHEN "backgroundColor"
            CALL populate_completer_sql("color", BUFFER) RETURNING list
        WHEN "border"
            CALL populate_completer_sql("border", BUFFER) RETURNING list
        WHEN "defaultTTFColor"
            CALL populate_completer_sql("color", BUFFER) RETURNING list
        WHEN "fontFamily"
            CALL populate_completer_sql("font_family", BUFFER) RETURNING list
        WHEN "fontSize"
            CALL populate_completer_sql("font_size", BUFFER) RETURNING list
        WHEN "fontStyle"
            CALL populate_completer_sql("font_style", BUFFER) RETURNING list
        WHEN "fontWeight"
            CALL populate_completer_sql("font_weight", BUFFER) RETURNING list

        WHEN "textColor"
            CALL populate_completer_sql("color", BUFFER) RETURNING list
        WHEN "textDecoration"
            CALL populate_completer_sql("text_decoration", BUFFER) RETURNING list
    END CASE

    CALL d.setCompleterItems(list)
END FUNCTION
FUNCTION populate_completer_sql(name STRING, BUFFER STRING) RETURNS itemsListType
    DEFINE sql STRING
    DEFINE value STRING
    DEFINE list itemsListType

    LET sql = "SELECT FIRST 50 value FROM common_style_attributes WHERE name = ? AND value LIKE ? ORDER BY weight, value"
    LET BUFFER = BUFFER, "%"

    DECLARE style_value_curs CURSOR FROM sql
    OPEN style_value_curs USING name, BUFFER

    FOREACH style_value_curs INTO value
        LET list[list.getLength() + 1] = value
    END FOREACH
    RETURN list
END FUNCTION

-- build per file
--write from scratch
FUNCTION build_per() RETURNS STRING
    DEFINE sb base.StringBuffer
    DEFINE i INTEGER

    LET sb = base.StringBuffer.create()
    CALL sb.append("LAYOUT (TEXT=\"Widget & Style Demo\")\n")
    IF m_data.container_name == "grid" OR m_data.container_name == "GRID" THEN
        CALL sb.append("    GRID\n" || "    {\n")  -- TODO set grid width to entered value
        CALL sb.append("        Control [f01                 : ]\n" || "        Test    [f02                 : ]\n")
        CALL sb.append("    }\n")
    ELSE IF m_data.container_name == "table" OR m_data.container_name == "TABLE" THEN
        CALL sb.append("    TABLE\n" || "    {\n") -- TODO set table width to entered value
        CALL sb.append("     Control     Test     \n" || "    [f01        |f02        ]\n")
        CALL sb.append("    }\n")  
    ELSE IF m_data.container_name == "folder" OR m_data.container_name == "FOLDER" THEN
        CALL sb.append("    FOLDER\n")
        CALL sb.append("        PAGE pg1 (TEXT=\"Widget_name\")\n")
        CALL sb.append("            GRID\n" || "            {\n")
        CALL sb.append("                Control [f01                 : ]\n")
        CALL sb.append("            }\n" || "            END\n")
        CALL sb.append("        END\n")
        CALL sb.append("        PAGE pg2 (TEXT=\"Widget_attributes\")\n")
        CALL sb.append("            GRID\n" || "            {\n")
        CALL sb.append("                Test    [f02                 : ]\n")
        CALL sb.append("            }\n" || "            END\n")
        CALL sb.append("        END\n")
    END IF
    END IF
    END IF 
    CALL sb.append("    END\n")
    CALL sb.append("END\n" || "ATTRIBUTES\n")
    CALL sb.append(m_data.widget_name || " f01 = formonly.ctrl;\n")
    CALL sb.append(m_data.widget_name || " f02 = formonly.test1, STYLE=\"test\"")
    FOR i = 1 TO m_data.widget_attribute_arr.getLength()
        IF m_data.widget_attribute_arr[i].widget_attribute_name.getLength() > 0 THEN
            CALL sb.append(", ")
            IF case_style == "upshift" THEN
                CALL sb.append(upshift(m_data.widget_attribute_arr[i].widget_attribute_name))
            ELSE
                CALL sb.append(downshift(m_data.widget_attribute_arr[i].widget_attribute_name))
            END IF
        END IF
        IF m_data.widget_attribute_arr[i].widget_attribute_value.getLength() > 0 THEN
            CALL sb.append(" = ")
            -- TODO implement a way to determine if value is quoted or not
            CALL sb.append(m_data.widget_attribute_arr[i].widget_attribute_value)
        END IF
    END FOR
    CALL sb.append(";\n")
    CALL sb.append("END\n")

    VAR t TEXT
    LOCATE t IN MEMORY
    LET t =  sb.toString()
    CALL t.writeFile("styledemo_test.per")
    RETURN sb.toString()
END FUNCTION

-- build 4st file.
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
    CALL style_node.setAttribute("name", m_data.widget_name)
    FOR i = 1 TO m_data.widget_style_arr.getLength()
        LET styleattribute_node = style_node.appendChildElement("StyleAttribute")
        CALL styleattribute_node.setAttribute("name", m_data.widget_style_arr[i].widget_style_attribute_name)
        CALL styleattribute_node.setAttribute("value", m_data.widget_style_arr[i].widget_style_attribute_value)
    END FOR

    -- .test Style
    LET style_node = stylelist_node.appendChildElement("Style")
    CALL style_node.setAttribute("name", ".test")
    FOR i = 1 TO m_data.common_style_arr.getLength()
        LET styleattribute_node = style_node.appendChildElement("StyleAttribute")
        CALL styleattribute_node.setAttribute("name", m_data.common_style_arr[i].common_style_attribute_name)
        CALL styleattribute_node.setAttribute("value", m_data.common_style_arr[i].common_style_attribute_value)
    END FOR
    CALL doc.save("styledemo_test.4st")
    RETURN stylelist_node.toString()
END FUNCTION
