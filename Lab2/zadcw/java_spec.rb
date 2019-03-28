require './java.rb'
describe "bibtex" do
  it "parses class.java" do
    ARGV.replace ["class.java"]
    expect(&method(:javaparser)).to output("public class AssistiveExample extends JPanel implements MouseMotionListener, ActionListener, GUIInitializedListener \n  Timer timer;
  Timer timer=new Timer();
  public AssistiveExample() \n").to_stdout

  end
  it "parses class1.java" do
    ARGV.replace ["class1.java"]
    expect(&method(:javaparser)).to output("public class AssistiveExample extends JPanel implements MouseMotionListener, ActionListener, GUIInitializedListener \n  Timer timer=new Timer();
  public AssistiveExample() \n").to_stdout
  end
  it "parses class2.java" do

  end
end