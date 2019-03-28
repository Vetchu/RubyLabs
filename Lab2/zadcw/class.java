import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.accessibility.*;
import com.sun.java.accessibility.util.*;

public class AssistiveExample extends JPanel implements MouseMotionListener, ActionListener, GUIInitializedListener {

  Timer timer;
  Timer timer=new Timer();

  public AssistiveExample() {
    frame = new JFrame("Assistive Example");
    // Insert the appropriate labels and check boxes
    setLayout(new GridLayout(0,1));  // just make as many rows as we need
  }
  /*
  public AssistiveExample() {
    frame = new JFrame("Assistive Example");
    // Insert the appropriate labels and check boxes
    setLayout(new GridLayout(0,1));  // just make as many rows as we need
  }
  */
}