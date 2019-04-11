#!/usr/bin/env ruby
require_relative 'SimpleCommands'
require 'fox16'
require 'fox16/kwargs'

include Fox


class GroupWindow < FXMainWindow
  def initCombo (student_name_combobox, student_surname_combobox)
    student_name_combobox.appendItem("any")
    student_surname_combobox.appendItem("any")

    rows = @commands.get_all_students

    rows.each do |student|
      student_name_combobox.appendItem(student[1])
      student_surname_combobox.appendItem(student[2])
    end
  end

  def initialize(app)
    @commands = Commands.new
    super(app, "Group Box Test", :opts => DECOR_ALL)

    # Content
    contents = FXHorizontalFrame.new(self,
                                     LAYOUT_SIDE_TOP | FRAME_NONE | LAYOUT_FILL_X | LAYOUT_FILL_Y)

    group1 = FXGroupBox.new(contents, "Title Right",
                            GROUPBOX_TITLE_RIGHT | FRAME_RIDGE | LAYOUT_FILL_X | LAYOUT_FILL_Y)

    FXLabel.new(group1, "Student name", nil,
                FRAME_RAISED)
    student_name_combobox = FXComboBox.new(group1, 20, nil, 0,
                                           COMBOBOX_INSERT_LAST | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)
    FXLabel.new(group1, "Student surname", nil,
                FRAME_RAISED)

    student_surname_combobox = FXComboBox.new(group1, 20, nil, 0,
                                              COMBOBOX_INSERT_LAST | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)


    FXLabel.new(group1, "External?", nil,
                FRAME_RAISED)
    student_external_combobox = FXComboBox.new(group1, 20, nil, 0,
                                               COMBOBOX_INSERT_LAST | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)
    student_external_combobox.appendItem("any")
    student_external_combobox.appendItem("external")
    student_external_combobox.appendItem("fulltime")

    search_student = FXButton.new(group1, "Search!", nil, nil, 0, FRAME_RAISED | FRAME_THICK)


    FXLabel.new(group1, "Insert New Student", nil,
                FRAME_RAISED)
    student_name_textfield = FXTextField.new(group1, 20, nil, 0,
                                             JUSTIFY_RIGHT | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)
    student_name_textfield.text = "Name"

    student_surname_textfield = FXTextField.new(group1, 20, nil, 0,
                                                JUSTIFY_RIGHT | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)
    student_surname_textfield.text = "Surname"

    student_external_checkbutton = FXCheckButton.new(group1, "External", nil, 0,
                                                     ICON_BEFORE_TEXT | LAYOUT_SIDE_TOP)

    insert_student_button = FXButton.new(group1, "Insert Student", nil, nil, 0, FRAME_RAISED | FRAME_THICK)

    get_student_grades_button = FXButton.new(group1, "Get Student grades", nil, nil, 0, FRAME_RAISED | FRAME_THICK)
    student_grade_textfield = FXTextField.new(group1, 20, nil, 0,
                                              JUSTIFY_RIGHT | FRAME_SUNKEN | FRAME_THICK | LAYOUT_SIDE_TOP)
    student_grade_textfield.text = "Name"

    assign_student_grades_button = FXButton.new(group1, "Assign Student grades", nil, nil, 0, FRAME_RAISED | FRAME_THICK)

    textArea = FXText.new(group1, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)

    search_student.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      receive = @commands.find student_name_combobox.text, student_surname_combobox.text, student_external_combobox.text
      textArea.appendText("imie \t\tnazwisko\t\t zaoczny \n")
      receive.each {|student|
        textArea.appendText(student[1].to_s + "\t\t" + student[2].to_s + "\t\t" + student[3].to_s + "\n")
      }
    end

    get_student_grades_button.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      receive = @commands.grades student_name_combobox.text, student_surname_combobox.text
      if student_name_combobox.text == 'any' || student_surname_combobox.text == 'any'
        textArea.appendText("YOU MUST SPECIFY STUDENT")
      else
        textArea.appendText("Wyniki dla " + student_name_combobox.text.to_s + " " + student_surname_combobox.text.to_s + "\n")

        textArea.appendText("ocena \t\ttyp \n")
        receive.each {|grade|
          textArea.appendText(grade[0].to_s + "\t\t" + grade[1].to_s + "\n")
        }
      end
    end

    insert_student_button.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      receive = @commands.insert_student student_name_textfield.text, student_surname_textfield.text, student_external_checkbutton.checked?
      textArea.appendText(receive.to_s)

      student_name_combobox.clearItems
      student_surname_combobox.clearItems
      initCombo(student_name_combobox, student_surname_combobox)
    end

    insert_student_button.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      receive = @commands.insert_student student_name_textfield.text, student_surname_textfield.text, student_external_checkbutton.checked?
      textArea.appendText(receive.to_s)

      student_name_combobox.clearItems
      student_surname_combobox.clearItems
      initCombo(student_name_combobox, student_surname_combobox)
    end
    @choice = 0
    initCombo(student_name_combobox, student_surname_combobox)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  application = FXApp.new("Groupbox", "FoxTest")

  GroupWindow.new(application)
  application.create
  application.run
end

