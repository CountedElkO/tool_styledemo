IMPORT util

FUNCTION populate_db()

    CALL widget_names()
    CALL widget_attribute_names()
    CALL widget_attribute_values()
    CALL container_names()
    CALL dialog_names()
    CALL style_names()
    CALL common_style_attributes()
    CALL widget_style_names()
    CALL widget_style_values()

END FUNCTION

FUNCTION widget_names()
    CREATE table widget_names(widget CHAR(20), weight INTEGER, widget_camelcase char(20))

    INSERT INTO widget_names VALUES ("aggregate", 1, "Aggregate")
    INSERT INTO widget_names VALUES ("buttonedit", 2, "ButtonEdit")
    INSERT INTO widget_names VALUES ("checkbox", 3, "CheckBox")
    INSERT INTO widget_names VALUES ("combobox", 4, "ComboBox")
    INSERT INTO widget_names VALUES ("dateedit", 5, "DateEdit")
    INSERT INTO widget_names VALUES ("datetimeedit", 6, "DateTimeEdit")
    INSERT INTO widget_names VALUES ("edit", 7, "Edit")
    INSERT INTO widget_names VALUES ("image", 8, "Image")
    INSERT INTO widget_names VALUES ("label", 9, "Label")
    INSERT INTO widget_names VALUES ("progressbar", 10, "ProgressBar")
    INSERT INTO widget_names VALUES ("radiogroup", 11, "Radiogroup")
    INSERT INTO widget_names VALUES ("slider", 12, "Slider")
    INSERT INTO widget_names VALUES ("spinedit", 13, "SpinEdit")
    INSERT INTO widget_names VALUES ("table", 14, "Table")    
    INSERT INTO widget_names VALUES ("textedit", 15, "TextEdit")
    INSERT INTO widget_names VALUES ("timeedit", 16, "TimeEdit")
    
END FUNCTION
function datatype_names()
    CREATE table datatype_names(widget CHAR(20), weight INTEGER, datatype_camelcase char(20))

    insert into datatype_names values ("char", 1, "Char")
    insert into datatype_names values ("boolean", 2, "Boolean")
    insert into datatype_names values ("integer", 3, "Integer")
    insert into datatype_names values ("date", 4, "Date")
    insert into datatype_names values ("datetime", 5, "DateTime")
    insert into datatype_names values ("interval", 6, "Interval")
    insert into datatype_names values ("decimal", 7, "Decimal")
    insert into datatype_names values ("float", 8, "Float")
end function   
  
FUNCTION widget_attribute_names()
    CREATE table widget_attribute_names (widget CHAR(20), name CHAR(20), weight INTEGER)
    
    INSERT INTO widget_attribute_names VALUES ("aggregate", "aggregatetext", 10) 
    INSERT INTO widget_attribute_names VALUES ("aggregate", "aggregatetype", 11) 

    
    INSERT INTO widget_attribute_names VALUES ("edit", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("edit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("edit", "invisible", 3) 
    INSERT INTO widget_attribute_names VALUES ("edit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("edit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("edit", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("edit", "stretch", 7)
    INSERT INTO widget_attribute_names VALUES ("edit", "upshift", 8)
    INSERT INTO widget_attribute_names VALUES ("edit", "downshift", 9)

    INSERT INTO widget_attribute_names VALUES ("buttonedit", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "invisible", 3) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("buttonedit", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("checkbox", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("checkbox", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("checkbox", "text", 14) 

    
    INSERT INTO widget_attribute_names VALUES ("combobox", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "invisible", 3) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("combobox", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("dateedit", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "invisible", 3) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("dateedit", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "invisible", 3) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("datetimeedit", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("image", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("image", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("image", "stretch", 7)
    
    INSERT INTO widget_attribute_names VALUES ("label", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("label", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("label", "stretch", 7)
    INSERT INTO widget_attribute_names VALUES ("label", "text", 14)

    
    INSERT INTO widget_attribute_names VALUES ("progressbar", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("progressbar", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("progressbar", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("radiogroup", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "stretch", 7)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "include", 13)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "key", 15)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "orientation", 16)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "required", 17)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "size policy", 18)
    INSERT INTO widget_attribute_names VALUES ("radiogroup", "style", 19)

    INSERT INTO widget_attribute_names VALUES ("table", "comment", 2)
    INSERT INTO widget_attribute_names VALUES ("table", "stretch", 7)
    INSERT INTO widget_attribute_names VALUES ("table", "aggregatetext", 10)
    INSERT INTO widget_attribute_names VALUES ("table", "width", 12)

    INSERT INTO widget_attribute_names VALUES ("textedit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("textedit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("textedit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("textedit", "scroll", 6) 
    INSERT INTO widget_attribute_names VALUES ("textedit", "stretch", 7)

    INSERT INTO widget_attribute_names VALUES ("timeedit", "autonext", 1) 
    INSERT INTO widget_attribute_names VALUES ("timeedit", "comment", 2) 
    INSERT INTO widget_attribute_names VALUES ("timeedit", "justify", 4) 
    INSERT INTO widget_attribute_names VALUES ("timeedit", "placeholder", 5) 
    INSERT INTO widget_attribute_names VALUES ("timeedit", "stretch", 7)
    
END FUNCTION

FUNCTION widget_attribute_values()
    CREATE TABLE widget_attribute_values (name CHAR(20), value CHAR(20), weight INTEGER, quote BOOLEAN)
    -- TODO change widget_attribute_values format to this
    INSERT INTO widget_attribute_values VALUES ("justify", "left", 1, false) 
    INSERT INTO widget_attribute_values VALUES ("justify", "center", 2, false) 
    INSERT INTO widget_attribute_values VALUES ("justify", "right", 3, false) 

    INSERT INTO widget_attribute_values VALUES ("stretch", "none", 1, false)
    INSERT INTO widget_attribute_values VALUES ("stretch", "x", 2, false)
    INSERT INTO widget_attribute_values VALUES ("stretch", "y", 3, false)
    INSERT INTO widget_attribute_values VALUES ("stretch", "both", 4, false)

    INSERT INTO widget_attribute_values VALUES ("wordwrap", "compress", 1, false)
    INSERT INTO widget_attribute_values VALUES ("wordwrap", "noncompress", 2, false)

    INSERT INTO widget_attribute_values VALUES ("comment", "", 1, TRUE)
    
    INSERT INTO widget_attribute_values VALUES ("placeholder", "", 1, true)

END FUNCTION

FUNCTION container_names()
    CREATE TABLE container_names (container CHAR(20), weight INTEGER, widget_camelcase char(20))
    INSERT INTO container_names VALUES ("grid", 1, "Grid")
    INSERT INTO container_names VALUES ("table", 2, "Table")
    INSERT INTO container_names VALUES ("scrollgrid", 3, "ScrollGrid")
    INSERT INTO container_names VALUES ("matrix", 4, "Matrix")
    INSERT INTO container_names VALUES ("tree", 5, "Tree")
END FUNCTION

FUNCTION dialog_names()
    CREATE TABLE dialog_names (dialog CHAR(20), weight INTEGER, widget_camelcase char(20))
    INSERT INTO dialog_names VALUES ("input", 1, "Input")
    INSERT INTO dialog_names VALUES ("menu", 2, "Menu")
    INSERT INTO dialog_names VALUES ("construct", 3, "Construct")
    INSERT INTO dialog_names VALUES ("display array", 4, "Display Array")
    INSERT INTO dialog_names VALUES ("input array", 5, "Input Array")
END FUNCTION

FUNCTION style_names()
    CREATE TABLE style_names (widget CHAR(20), name CHAR(20), weight INTEGER)
    -- Common https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_common_style_attributes.html
    INSERT INTO style_names VALUES("common", "", 1)
    INSERT INTO style_names VALUES("common", "backgroundColor", 1)
    INSERT INTO style_names VALUES("common", "border", 1)
    INSERT INTO style_names VALUES("common", "defaultTTFColor", 1)
    INSERT INTO style_names VALUES("common", "fontFamily", 1)
    INSERT INTO style_names VALUES("common", "fontSize", 1)
    INSERT INTO style_names VALUES("common", "fontStyle", 1)
    INSERT INTO style_names VALUES("common", "fontWeight", 1)
    INSERT INTO style_names VALUES("common", "textColor", 1)
    INSERT INTO style_names VALUES("common", "textDecoration", 1)

    CREATE INDEX sn1 ON style_names(widget, weight, name)
END FUNCTION

FUNCTION common_style_attributes()
    DEFINE i INTEGER
    DEFINE s STRING

    CREATE TABLE common_style_attributes (name CHAR(20), value CHAR(20), weight INTEGER)

    -- border https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_common_style_attributes.html#r_fgl_presentation_styles_common_style_attributes__row_border
    INSERT INTO common_style_attributes VALUES("border", "no", 1)
    INSERT INTO common_style_attributes VALUES("border", "yes", 1)

    -- font size https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_presentation_styles_font_size.html
    INSERT INTO common_style_attributes VALUES("font_size", "xx-small", 1)
    INSERT INTO common_style_attributes VALUES("font_size", "x-small", 2)
    INSERT INTO common_style_attributes VALUES("font_size", "small", 3)
    INSERT INTO common_style_attributes VALUES("font_size", "medium", 4)
    INSERT INTO common_style_attributes VALUES("font_size", "large", 5)
    INSERT INTO common_style_attributes VALUES("font_size", "x-large", 6)
    INSERT INTO common_style_attributes VALUES("font_size", "xx-large", 7)
    FOR i = 1 TO 96
        LET s = i USING "<<", "pt"
        INSERT INTO common_style_attributes VALUES("font_size", s, 30 + i)
    END FOR
    INSERT INTO common_style_attributes VALUES("font_size", "0.5em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "0.75em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "1em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "1.25em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "1.5em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "2em", 20)
    INSERT INTO common_style_attributes VALUES("font_size", "3em", 20)

    -- font style https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_presentation_styles_font_style.html
    INSERT INTO common_style_attributes VALUES("font_style", "italic", 1)
    INSERT INTO common_style_attributes VALUES("font_style", "oblique", 1)
    INSERT INTO common_style_attributes VALUES("font_style", "roman", 1)

    -- font weight https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_presentation_styles_font_weight.html
    INSERT INTO common_style_attributes VALUES("font_weight", "normal", 1)
    INSERT INTO common_style_attributes VALUES("font_weight", "bold", 1)
    INSERT INTO common_style_attributes VALUES("font_weight", "bolder", 1)
    INSERT INTO common_style_attributes VALUES("font_weight", "lighter", 1)
    FOR i = 1 TO 1000
        LET s = i USING "<<<<"
        INSERT INTO common_style_attributes VALUES("font_weight", s, 10 + i)
    END FOR

    -- text decoration https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_common_style_attributes.html#r_fgl_presentation_styles_common_style_attributes__row_textDecoration
    INSERT INTO common_style_attributes VALUES("text_decoration", "line-through", 1)
    INSERT INTO common_style_attributes VALUES("text_decoration", "overline", 1)
    INSERT INTO common_style_attributes VALUES("text_decoration", "underline", 1)

    -- backgroundColor, defaultTTGColorm textColor https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_presentation_styles_015.html
    -- list the TTY colors first
    INSERT INTO common_style_attributes VALUES("color", "black", 1)
    INSERT INTO common_style_attributes VALUES("color", "blue", 1)
    INSERT INTO common_style_attributes VALUES("color", "cyan", 1)
    INSERT INTO common_style_attributes VALUES("color", "green", 1)
    INSERT INTO common_style_attributes VALUES("color", "magenta", 1)
    INSERT INTO common_style_attributes VALUES("color", "red", 1)
    INSERT INTO common_style_attributes VALUES("color", "white", 1)
    INSERT INTO common_style_attributes VALUES("color", "yellow", 1)
    -- add html colors here
    INSERT INTO common_style_attributes VALUES("color", "darkBlue", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkCyan", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkGreen", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkMagenta", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkOlive", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkRed", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkOrange", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkGray", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkTeal", 2)
    INSERT INTO common_style_attributes VALUES("color", "darkYellow", 2)
    INSERT INTO common_style_attributes VALUES("color", "gray", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightBlue", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightCyan", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightGray", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightGreen", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightMagenta", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightOlive", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightOrange", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightRed", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightTeal", 2)
    INSERT INTO common_style_attributes VALUES("color", "lightYellow", 2)
    INSERT INTO common_style_attributes VALUES("color", "olive", 2)
    INSERT INTO common_style_attributes VALUES("color", "orange", 2)
    INSERT INTO common_style_attributes VALUES("color", "teal", 2)
    -- added generic colors
    INSERT INTO common_style_attributes VALUES("color", "appWorkSpace", 3)
    INSERT INTO common_style_attributes VALUES("color", "background", 3)
    INSERT INTO common_style_attributes VALUES("color", "buttonFace", 3)
    INSERT INTO common_style_attributes VALUES("color", "buttonText", 3)
    INSERT INTO common_style_attributes VALUES("color", "grayText", 3)
    INSERT INTO common_style_attributes VALUES("color", "highLight", 3)
    INSERT INTO common_style_attributes VALUES("color", "highLightText", 3)
    INSERT INTO common_style_attributes VALUES("color", "infoBackground", 3)
    INSERT INTO common_style_attributes VALUES("color", "infoText", 3)
    INSERT INTO common_style_attributes VALUES("color", "systemAlternateBackground", 3)
    INSERT INTO common_style_attributes VALUES("color", "window", 3)
    INSERT INTO common_style_attributes VALUES("color", "windowText", 3)
    
    -- TODO maybe do a widget for these
    -- all 655356 RGB colors
    FOR i = 0 TO 65536
        LET s = util.Integer.toHexString(i)
        CASE s.getLength()
            WHEN 1
                LET s = "00000", s
            WHEN 2
                LET s = "0000", s
            WHEN 3
                LET s = "000", s
            WHEN 4
                LET s = "00", s
            WHEN 5
                LET s = "0", s
        END CASE
        LET s = "#", s
        INSERT INTO common_style_attributes VALUES("color", s, 4)
    END FOR

    -- Font-family https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_fgl_presentation_styles_font_family.html
    INSERT INTO common_style_attributes VALUES("font_family", "serif", 1)
    INSERT INTO common_style_attributes VALUES("font_family", "sans_serif", 2)
    INSERT INTO common_style_attributes VALUES("font_family", "monospace", 3)
    INSERT INTO common_style_attributes VALUES("font_family", "cursive", 4)
    INSERT INTO common_style_attributes VALUES("font_family", "fantasy", 5)
    -- TODO, where to get list from, how to handle spaces
    INSERT INTO common_style_attributes VALUES("font_family", "courier", 6)
    INSERT INTO common_style_attributes VALUES("font_family", "times new roman", 7)
    INSERT INTO common_style_attributes VALUES("font_family", "helvetica", 8)

    CREATE INDEX sa1 ON common_style_attributes(name, weight, value)
END FUNCTION

FUNCTION widget_style_names()
    CREATE table widget_style_names (widget CHAR(20), name CHAR(20), weight INTEGER)
    INSERT INTO widget_style_names VALUES ("buttonedit", "scaleIcon", 1)
    INSERT INTO widget_style_names VALUES ("checkbox", "customWidget", 1)
    INSERT INTO widget_style_names VALUES ("dateedit", "calendarType", 1)
    INSERT INTO widget_style_names VALUES ("dateedit", "daysOff", 2)
    INSERT INTO widget_style_names VALUES ("dateedit", "firstDayOfWeek", 3)
    INSERT INTO widget_style_names VALUES ("dateedit", "showCurrentMonthOnly", 4)
    INSERT INTO widget_style_names VALUES ("dateedit", "showWeekNumber", 5)
    INSERT INTO widget_style_names VALUES ("datetimeedit", "calendarType", 1)
    INSERT INTO widget_style_names VALUES ("datetimeedit", "daysOff", 2)
    INSERT INTO widget_style_names VALUES ("datetimeedit", "firstDayOfWeek", 3)
    INSERT INTO widget_style_names VALUES ("datetimeedit", "showCurrentMonthOnly", 4)
    INSERT INTO widget_style_names VALUES ("datetimeedit", "showWeekNumber", 5)
    INSERT INTO widget_style_names VALUES ("image", "alignment", 1)
    INSERT INTO widget_style_names VALUES ("label", "sanitize", 1)
    INSERT INTO widget_style_names VALUES ("label", "textFormat", 2)
    INSERT INTO widget_style_names VALUES ("progressbar", "percentageVisible", 1)
    INSERT INTO widget_style_names VALUES ("textedit", "sanitize", 1)
    INSERT INTO widget_style_names VALUES ("textedit", "textFormat", 2)
    INSERT INTO widget_style_names VALUES ("textedit", "showeditToolBox", 3)
    INSERT INTO widget_style_names VALUES ("textedit", "wrapPolicy", 4)
END FUNCTION

FUNCTION widget_style_values()
    DEFINE i INTEGER
    DEFINE s STRING
    CREATE TABLE widget_style_values (name CHAR(20), value CHAR(20), weight INTEGER)
    INSERT INTO widget_style_values VALUES ("scaleIcon", "no", 1)
    INSERT INTO widget_style_values VALUES ("scaleIcon", "yes", 2)
    FOR i = 0 TO 72
        LET s = i USING "<<", "px"
        INSERT INTO widget_style_values VALUES ("scaleIcon", s, i+3)
    END FOR
    INSERT INTO widget_style_values VALUES ("customWidget", "toggleButton", 1)
    INSERT INTO widget_style_values VALUES ("calendarType", "dropdown", 1)
    INSERT INTO widget_style_values VALUES ("calendarType", "modal", 1)
    INSERT INTO widget_style_values VALUES ("daysOff", "monday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "tuesday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "wednesday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "thursday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "friday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "saturday", 2)
    INSERT INTO widget_style_values VALUES ("daysOff", "sunday", 2)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "monday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "tuesday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "wednesday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "thursday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "friday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "saturday", 3)
    INSERT INTO widget_style_values VALUES ("firstDayOfWeek", "sunday", 3)
    INSERT INTO widget_style_values VALUES ("showCurrentMonthOnly", "yes", 4)
    INSERT INTO widget_style_values VALUES ("showCurrentMonthOnly", "no", 4)
    INSERT INTO widget_style_values VALUES ("showWeekNumber", "yes", 5)
    INSERT INTO widget_style_values VALUES ("showWeekNumber", "no", 5)
    INSERT INTO widget_style_values VALUES ("alignment", "top left", 1)
    INSERT INTO widget_style_values VALUES ("alignment", "top horizontalCenter", 2)
    INSERT INTO widget_style_values VALUES ("alignment", "top right", 3)
    INSERT INTO widget_style_values VALUES ("alignment", "verticalCenter left", 4)
    INSERT INTO widget_style_values VALUES ("alignment", "verticalCenter horizontalCenter", 5)
    INSERT INTO widget_style_values VALUES ("alignment", "verticalCenter right", 6)
    INSERT INTO widget_style_values VALUES ("alignment", "bottom left", 7)
    INSERT INTO widget_style_values VALUES ("alignment", "bottom horizontalCenter", 8)
    INSERT INTO widget_style_values VALUES ("alignment", "bottom right", 9)
    INSERT INTO widget_style_values VALUES ("sanitize", "yes", 1)
    INSERT INTO widget_style_values VALUES ("sanitize", "no", 1)
    INSERT INTO widget_style_values VALUES ("textFormat", "plain", 2)
    INSERT INTO widget_style_values VALUES ("textFormat", "html", 2)
    INSERT INTO widget_style_values VALUES ("percentageVisible", "no", 1)
    INSERT INTO widget_style_values VALUES ("percentageVisible", "center", 2)
    INSERT INTO widget_style_values VALUES ("percentageVisible", "system", 3)
    INSERT INTO widget_style_values VALUES ("sanitize", "yes", 1)
    INSERT INTO widget_style_values VALUES ("sanitize", "no", 1)
    INSERT INTO widget_style_values VALUES ("textFormat", "plain", 2)
    INSERT INTO widget_style_values VALUES ("textFormat", "html", 2)
    INSERT INTO widget_style_values VALUES ("showeditToolBox", "no", 3)
    INSERT INTO widget_style_values VALUES ("showeditToolBox", "yes", 3)
    INSERT INTO widget_style_values VALUES ("wrapPolicy", "atWordBoundary", 4)
    INSERT INTO widget_style_values VALUES ("wrapPolicy", "anywhere", 4)
    -- buttonedit https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_buttonedit_style_attributes.html
    -- checkbox https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_checkbox_style_attributes.html
    -- dateedit https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_dateedit_style_attributes.html
    -- datetimeedit https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_datetimeedit_style_attributes.html
    -- image https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_image_style_attributes.html
    -- label https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_label_style_attributes.html
    -- progressbar https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_progressbar_style_attributes.html
    -- textedit https://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/r_fgl_presentation_styles_textedit_style_attributes.html
END FUNCTION